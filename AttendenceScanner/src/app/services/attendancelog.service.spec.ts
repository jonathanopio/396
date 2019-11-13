import { TestBed } from '@angular/core/testing';

import { AttendancelogService } from './attendancelog.service';

describe('AttendancelogService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: AttendancelogService = TestBed.get(AttendancelogService);
    expect(service).toBeTruthy();
  });
});
