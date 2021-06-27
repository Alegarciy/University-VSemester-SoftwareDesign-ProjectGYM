import { Component, OnInit, Input } from "@angular/core";
import { MatDialog } from "@angular/material/dialog";
import Client from "src/app/Models/Clients/Client";
import { AdminScheduleService } from "src/app/Services/Dashboard/admin-schedule.service";
import { SessionsService } from "src/app/Services/SessionService/sessions.service";
import { AdminDialogueChangeComponent } from "../admin-dialogue-change/admin-dialogue-change.component";
import { AdminDialogueUncheckedComponent } from "../admin-dialogue-unchecked/admin-dialogue-unchecked.component";

@Component({
  selector: "app-admin-card-unchecked",
  templateUrl: "./admin-card-unchecked.component.html",
  styleUrls: ["./admin-card-unchecked.component.scss"],
})
export class AdminCardUncheckedComponent implements OnInit {
  @Input()
  session!: any;
  @Input()
  instructor!: any;
  @Input()
  sessionService!: any;
  @Input()
  instructorArray: any;

  constructor(
    private sessionScheduleService: SessionsService,
    private adminScheduleService: AdminScheduleService,
    public dialog: MatDialog
  ) {}

  ngOnInit(): void {}

  openDialogue() {
    ("Dialogue open 🎊");
    this.adminScheduleService.getSessionParticipant(this.session).subscribe(
      (res) => {
        if (res.body != null) {
          let participants: Client[] = [];
          res.body.forEach((participant: Client) => {
            participants.push(participant);
          });

          if (participants != []) {
            console.log("There are Participants 👨‍🦰👨‍🦰👨‍🦰");
            this.openDialogue_aux(participants);
          } else {
            // deberia ser error desde la base
            console.log("No single Participants 👨‍🦰");
          }
        }
      },
      (err) => {
        console.log("Error: No Participants 💀💀💀");
      }
    );
  }

  openDialogue_aux(participants: Client[]) {
    const dialogRef = this.dialog.open(AdminDialogueUncheckedComponent, {
      data: {
        participantsArray: participants,
      },
    });

    dialogRef.afterClosed().subscribe((result) => {
      console.log(`Dialog result: ${result}`);
      console.log(result);
    });
  }
}
