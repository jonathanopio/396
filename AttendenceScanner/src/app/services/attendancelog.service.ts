import { Injectable } from '@angular/core';
import { AngularFirestore, AngularFirestoreCollection } from 'angularfire2/firestore';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
 
export interface AttendanceLog {
  id?: string;
  task: string;
  priority: number;
  createdAt: number;
}
 
@Injectable({
  providedIn: 'root'
})
export class AttendanceLogService {
  private logCollection: AngularFirestoreCollection<AttendanceLog>;
 
  private logs: Observable < AttendanceLog[] >;
 
  constructor(db: AngularFirestore) {
    this.logCollection = db.collection<AttendanceLog>('logs');
 
    this.logs = this.logCollection.snapshotChanges().pipe(
      map(actions => {
        return actions.map(a => {
          const data = a.payload.doc.data();
          const id = a.payload.doc.id;
          return { id, ...data };
        });
      })
    );
  }
 
  getLog() {
    return this.logs;
  }
 
  getID(id) {
    return this.logCollection.doc<AttendanceLog>(id).valueChanges();
  }
 
  updateLog(AttendancelogService: AttendanceLog, id: string) {
    return this.logCollection.doc(id).update(AttendancelogService);
  }
 
  addLog(AttendancelogService: AttendanceLog) {
    return this.logCollection.add(AttendancelogService);
  }
 
  removeLog(id) {
    return this.logCollection.doc(id).delete();
  }
}