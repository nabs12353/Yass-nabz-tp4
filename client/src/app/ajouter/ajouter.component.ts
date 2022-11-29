import { Component, OnInit, ViewChild, ElementRef} from '@angular/core';
import { CommunicationService } from "./../communication.service";
import { Planrepas } from "../../../../common/tables/Planrepas";
@Component({
  selector: 'app-ajouter',
  templateUrl: './ajouter.component.html',
  styleUrls: ['./ajouter.component.css']
})
export class AjouterComponent implements OnInit {
  @ViewChild("numplan") numplan: ElementRef;
  @ViewChild("categorie") categorie: ElementRef;
  @ViewChild("freq") freq: ElementRef;
  @ViewChild("nbpers") nbpers: ElementRef;
  @ViewChild("calories") calories: ElementRef;
  @ViewChild("prix") prix: ElementRef;
  @ViewChild("numfourn") numfourn: ElementRef;
  public plans: Planrepas[] = [];
  public duplicateError: boolean = false;

  public nbplan: string;
  public categ: string;
  public frequence: number;
  public nbpersonnes: number;
  public cal: number;
  public price: number;
  public numfourni: string;
  constructor(private communicationService: CommunicationService) { }

  public ngOnInit(): void {
    this.getPlansRepas();
    this.nbplan = this.randomNumeroPlan();
    this.categ = this.randomCategorie();
    this.frequence = this.randomFrequence();
    this.nbpersonnes = this.randomNbrPersonnes();
    this.cal = this.randomNbCalories();
    this.price = this.randomPrix();
    this.numfourni = this.randomNumeroFournisseur();
  }

  public getPlansRepas(): void {
    this.communicationService.getPlansRepas().subscribe((plans: Planrepas[]) => {
      this.plans = plans;
    });
  }

  public insertPlan(): void {
    const plan: any = {
      numeroplan: this.numplan.nativeElement.innerText,
      categorie: this.categorie.nativeElement.innerText,
      frequence: this.freq.nativeElement.innerText,
      nbrpersonnes: this.nbpers.nativeElement.innerText,
      nbcalories: this.calories.nativeElement.innerText,
      prix: this.prix.nativeElement.innerText,
      numerofournisseur: this.numfourn.nativeElement.innerText,
    };

    this.communicationService.insertPlan(plan).subscribe((res: number) => {
      if (res > 0) {
        this.communicationService.filter("update");
      }
      this.refresh();
      this.duplicateError = res === -1;
    });
  }
  private refresh() {
    this.getPlansRepas();
  }

  private randomNumeroPlan(){
    var randomNPl = this.randomIntFromInterval(0,1000);
    return randomNPl.toString() ;
 }
  private randomCategorie(){
    var myArray = ["vege","lilot","calmite", "marlofe", "poul" , "keto" , "marline" , "linono"];
    var randomCa = myArray[Math.floor(Math.random()*myArray.length)];
    return randomCa ;
 }

  private randomFrequence(){
    var randomFr = this.randomIntFromInterval(0,14);
    return randomFr ;
 }
  private randomNbrPersonnes(){
    var randomPe = this.randomIntFromInterval(0,1000);
    return randomPe ;
 }
  private randomNbCalories(){
    var randomNCa = this.randomIntFromInterval(0,4000);
    return randomNCa ;
}
  private randomPrix(){
    var myArray = [12.32,18.67,20.00,22.00,27.00,34.65,76.43,67.76,43.21,89.09,21.76,12.23,44.32,19.34,65.43];
    var randomPr = myArray[Math.floor(Math.random()*myArray.length)];
    return randomPr ;
 }

  private randomNumeroFournisseur(){
    var randomNFo = this.randomIntFromInterval(0,6);
    return randomNFo.toString() ;
 }

  private randomIntFromInterval (min: number, max: number) {
    return Math.floor(Math.random() * (max - min + 1) + min)
  }
}
