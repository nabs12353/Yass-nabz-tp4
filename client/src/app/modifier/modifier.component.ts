import { Component, OnInit } from '@angular/core';
import { CommunicationService } from "./../communication.service";
import { Planrepas } from "../../../../common/tables/Planrepas";
@Component({
  selector: 'app-modifier',
  templateUrl: './modifier.component.html',
  styleUrls: ['./modifier.component.css']
})
export class ModifierComponent implements OnInit {

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

  public changeCategorie(event: any, i: number) {
    const editField = event.target.textContent;
    this.plans[i].categorie = editField;
  }

  public changeFrequence(event: any, i: number) {
    const editField = event.target.textContent;
    this.plans[i].frequence = editField;
  }

  public changeNbrPersonnes(event: any, i: number) {
    const editField = event.target.textContent;
    this.plans[i].nbrpersonnes = editField;
  }

  public changeNbCalories(event: any, i: number) {
    const editField = event.target.textContent;
    this.plans[i].nbcalories = editField;
  }

  public changePrix(event: any, i: number) {
    const editField = event.target.textContent;
    this.plans[i].prix = editField;
  }

  public changeNumeroFournisseur(event: any, i: number) {
    const editField = event.target.textContent;
    this.plans[i].numerofournisseur = editField;
  }

  public updatePlan(i: number) {
    this.communicationService
      .updatePlan(this.plans[i])
      .subscribe((res: any) => {
        this.ngOnInit();
      });
  }
}
