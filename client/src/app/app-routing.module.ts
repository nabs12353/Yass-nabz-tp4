import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";

import { AppComponent } from "./app.component";
import { PlanrepasComponent } from "./planrepas/planrepas.component";
import { AjouterComponent } from "./ajouter/ajouter.component";
import { ModifierComponent } from "./modifier/modifier.component";
import { SupprimerComponent } from "./supprimer/supprimer.component";

const routes: Routes = [
  { path: "app", component: AppComponent },
  { path: "planrepas", component: PlanrepasComponent },
  { path: "ajouter", component: AjouterComponent },
  { path: "modifier", component: ModifierComponent },
  { path: "supprimer", component: SupprimerComponent },
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule { }