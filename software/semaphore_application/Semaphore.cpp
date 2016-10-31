/*
 * Semaphore.cpp
 *
 *  Created on: Oct 25, 2016
 *      Authors: marcio Monteiro and Marleson Graf
 */

#include "HAL/inc/io.h"

#include "CPU.h"
#include "Semaphore.h"
#include "sys/alt_stdio.h"
#include "system.h"
#include "Thread.h"

namespace {
	unsigned read_status() {
		unsigned status = IORD_32DIRECT(Semaphore::BASE_ADDRESS, output::STATUS);
		while (!(status & (mask::DONE | mask::ERROR))) {
			status = IORD_32DIRECT(Semaphore::BASE_ADDRESS, output::STATUS);
		}
		return status;
	}
}

const unsigned long long Semaphore::BASE_ADDRESS = SEMAPHORE_BASE;

Semaphore::Semaphore(unsigned v) {
	alt_printf("Semaphore::Semaphore(%d) : ", v);

	CPU::int_disable();

	IOWR_32DIRECT(BASE_ADDRESS, input::COMMAND, command::CREATE);

	IOWR_32DIRECT(BASE_ADDRESS, input::DATA, v);

	int status = read_status();

	if (status & mask::ERROR) {
		alt_printf("\n\nERROR: maximum of semaphores reached!\n\n");
		throw -1;
	}

	id = IORD_32DIRECT(BASE_ADDRESS, output::DATA);

	CPU::int_enable();

	alt_printf("Semaphore %x created.\n\n", id);
}

Semaphore::~Semaphore() {
	alt_putstr("Semaphore::~Semaphore() : ");

	CPU::int_disable();

	IOWR_32DIRECT(BASE_ADDRESS, input::COMMAND, command::DESTROY);

	IOWR_32DIRECT(BASE_ADDRESS, input::SEMAPHORE, id);

	// TODO: remove this shit
	IOWR_32DIRECT(BASE_ADDRESS, input::DATA, 0);

	int status = read_status();

	if (status & mask::ERROR) {
		alt_printf("\n\nERROR: destroying semaphore with threads blocked!\n\n");
		throw -1;
	}

	CPU::int_enable();

	alt_printf("Semaphore %x destroyed.\n\n", id);
}

void Semaphore::p() {
	alt_printf("Calling p() in Semaphore %d...\n", id);

	Thread* thread = Thread::running();

	CPU::int_disable();

	IOWR_32DIRECT(BASE_ADDRESS, input::COMMAND, command::DOWN);

	IOWR_32DIRECT(BASE_ADDRESS, input::SEMAPHORE, id);

	IOWR_32DIRECT(BASE_ADDRESS, input::DATA, reinterpret_cast<int>(thread));

	int status = read_status();

	if (status & mask::ERROR) {
		if (status & mask::BLOCK) {
			alt_printf("\n\nERROR: No more space available to store blocked thread!\n\n");
		} else {
			alt_printf("ERROR: Attempt to call p() in non-existent semaphore!\n\n");
		}
		throw -1;
	}

	CPU::int_enable();

	if (status & mask::BLOCK) {
		alt_printf("\nBlocking thread %x...\n\n", thread);
	}
}

void Semaphore::v() {
	alt_printf("Calling v() in Semaphore %d...\n", id);

	CPU::int_disable();

	IOWR_32DIRECT(BASE_ADDRESS, input::COMMAND, command::UP);

	IOWR_32DIRECT(BASE_ADDRESS, input::SEMAPHORE, id);

	IOWR_32DIRECT(BASE_ADDRESS, input::DATA, 0);

	int status = read_status();

	if (status & mask::ERROR) {
		alt_printf("ERROR: Attempt to call v() in non-existent semaphore!\n\n");
		throw -1;
	}

	CPU::int_enable();

	if (status & mask::RESUME) {
		unsigned raw = IORD_32DIRECT(BASE_ADDRESS, output::DATA);
		Thread* thread = reinterpret_cast<Thread*>(raw);
		alt_printf("\nResuming thread %x...\n", thread);
	}

	alt_printf("\n");
}
