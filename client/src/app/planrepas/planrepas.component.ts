import { Component, OnInit } from '@angular/core';
import { CommunicationService } from "./../communication.service";
import { Planrepas } from "../../../../common/tables/Planrepas";
@Component({
  selector: 'app-planrepas',
  templateUrl: './planrepas.component.html',
  styleUrls: ['./planrepas.component.css']
})


export class PlanrepasComponent implements OnInit {
  public plans: Planrepas[] = [];

  constructor(private communicationService: CommunicationService) { }

  public ngOnInit(): void {
    this.getPlansRepas();
  }

  public getPlansRepas(): void {
    this.communicationService.getPlansRepas().subscribe((plans: Planrepas[]) => {
      this.plans = plans;
    });
  }
}
