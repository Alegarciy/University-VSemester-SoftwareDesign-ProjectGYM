import { Component, OnInit } from "@angular/core";
import { AuthService } from "src/app/Services/Auth/auth.service";
import { ClientScheduleService } from "src/app/Services/Dashboard/client-schedule.service";

import { Session } from "../../../../Models/Schedule/Session";

@Component({
  selector: "app-client-dashboard",
  templateUrl: "./client-dashboard.component.html",
  styleUrls: ["./client-dashboard.component.scss"],
})
export class ClientDashboardComponent implements OnInit {
  scheduleMap: Map<Date, any>;
  scheduleMapReservations: Map<String, any>;

  constructor(
    private authService: AuthService,
    private clientScheduleService: ClientScheduleService
  ) {
    this.scheduleMap = new Map();
    this.scheduleMapReservations = new Map();
  }

  ngOnInit(): void {
    this.getMonthlySessions();
    this.getMonthlyReservedSessions();
  }

  getMonthlySessions() {
    //load schedule
    this.clientScheduleService
      .getCurrentSessionSchedule()
      .subscribe((sessions: any) => {
        sessions.sessions.forEach((session: any, key: any) => {
          let scheduledSession = this.initSession(session);
          this.fillScheduleHashmap(scheduledSession);
        });
      });
  }
  getMonthlyReservedSessions() {
    this.clientScheduleService
      .getReservedSessions()
      .subscribe((reservedSessions: any) => {
        reservedSessions.sessions.forEach((session: any, key: any) => {
          this.scheduleMapReservations.set(session.id, session);
        });
      });
  }

  //Auxiliary function for getMonthlySessions
  fillScheduleHashmap(scheduledSession: Session) {
    if (scheduledSession.date != undefined) {
      let currentDay: any[] = this.scheduleMap.get(scheduledSession.date);
      if (currentDay == undefined) {
        this.scheduleMap.set(scheduledSession.date, [scheduledSession]);
      } else {
        currentDay.push(scheduledSession);
        this.scheduleMap.set(scheduledSession.date, currentDay);
      }
    }
  }
  //Receive a session Json
  initSession(sessionJson: any): Session {
    let scheduledSession: Session = {
      id: sessionJson.id,
      name: sessionJson.name,
      instructor: {
        name: sessionJson.session_instructor.name,
        identification: sessionJson.session_instructor.identification,
      },
      sessionService: {
        name: sessionJson.session_service.name,
        maxSpaces: sessionJson.session_service.max_spaces,
      },
      availableSpaces: sessionJson.available_spaces,
      cost: sessionJson.cost,
      date: sessionJson.date,
      time: sessionJson.time,
      duration: sessionJson.duration_min,
    };

    return scheduledSession;
  }

  isSessionReserved(sessionName: string) {
    return this.scheduleMapReservations.has(sessionName);
  }
}