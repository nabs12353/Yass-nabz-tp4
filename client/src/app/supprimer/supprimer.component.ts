import { Component, OnInit } from '@angular/core';
import { CommunicationService } from "./../communication.service";
import { Planrepas } from "../../../../common/tables/Planrepas";

@Component({
  selector: 'app-supprimer',
  templateUrl: './supprimer.component.html',
  styleUrls: ['./supprimer.component.css']
})
export class SupprimerComponent implements OnInit {
  public plans: Planrepas[] = [];
  constructor(private communicationService: CommunicationService) { }

  ngOnInit(): void {
    this.getPlansRepas();
  }
  public getPlansRepas(): void {
    this.communicationService.getPlansRepas().subscribe((plans: Planrepas[]) => {
      this.plans = plans;
    });
  }

  public deletePlan(numeroplan: string) {
    this.communicationService
      .deletePlan(numeroplan)
      .subscribe((res: any) => {
        this.ngOnInit();
      });
  }
}
