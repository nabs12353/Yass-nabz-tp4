import { injectable } from "inversify";
import * as pg from "pg";
import "reflect-metadata";
import { Planrepas } from "../../../common/tables/Planrepas";

@injectable()
export class DatabaseService {
  // TODO: A MODIFIER POUR VOTRE BD
  public connectionConfig: pg.ConnectionConfig = {
    user: "postgres",
    database: "TP4_Livraison",
    password: "nabmer14",
    port: 5432,
    host: "127.0.0.1",
    keepAlive: true,
  };

  public pool: pg.Pool = new pg.Pool(this.connectionConfig);

  // insert plan repas
  public async createPlan(plan: Planrepas): Promise<pg.QueryResult> {
    const client = await this.pool.connect();

    if (!plan.numeroplan || !plan.categorie || !plan.frequence || !plan.nbrpersonnes || !plan.nbcalories || !plan.prix || !plan.numerofournisseur)
      throw new Error("Invalide! Insérer des valeurs");

    const values: string[] = [
      plan.numeroplan, 
      plan.categorie, 
      plan.frequence.toString(), 
      plan.nbrpersonnes.toString(), 
      plan.nbcalories.toString(), 
      plan.prix.toString(), 
      plan.numerofournisseur];
    const queryText: string = `INSERT INTO TP4DB.PlanRepas VALUES($1, $2, $3, $4, $5, $6, $7);`;

    const res = await client.query(queryText, values);
    client.release();
    return res;
  }

  //get all plans repas
  public async getAllPlanRepas(PlanRepas: string): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const res = await client.query("SELECT * FROM TP4DB.PlanRepas;");
    client.release();
    return res;
  }

  public async updatePlan(plan: Planrepas): Promise<pg.QueryResult> {
    const client = await this.pool.connect();

    let toUpdateValues = [];
    if (plan.categorie.length > 0) toUpdateValues.push(`categorie = '${plan.categorie}'`);
    if (Number(plan.frequence) > 0) toUpdateValues.push(`frequence = '${plan.frequence}'`);
    if (Number(plan.nbrpersonnes) > 0) toUpdateValues.push(`nbrpersonnes = '${plan.nbrpersonnes}'`);
    if (Number(plan.nbcalories) > 0) toUpdateValues.push(`nbcalories = '${plan.nbcalories}'`);
    if (Number(plan.prix) > 0) toUpdateValues.push(`prix = '${plan.prix}'`);
    if (Number(plan.numerofournisseur) > 0) toUpdateValues.push(`numerofournisseur = '${plan.numerofournisseur}'`);
    console.log(toUpdateValues);

    if (
      parseInt(plan.numeroplan) === 0 ||
      Number(plan.frequence) < 0 ||
      Number(plan.nbrpersonnes) < 0 ||
      Number(plan.nbcalories) < 0 ||
      Number(plan.prix) < 0 ||
      parseInt(plan.numerofournisseur) < 0 ||
      toUpdateValues.length === 0
    )
      throw new Error("Données pour plan repas invalides!");

    const query = `UPDATE TP4DB.PlanRepas SET ${toUpdateValues.join(
      ", "
    )} WHERE numeroplan = '${plan.numeroplan}';`;
    const res = await client.query(query);
    client.release();
    return res;
  }

  public async deletePlan(
    numeroplan: string,
  ): Promise<pg.QueryResult> {
    if (parseInt(numeroplan) === 0) throw new Error("numéro de plan invalide !");
    const client = await this.pool.connect();

    const query = `DELETE FROM TP4DB.PlanRepas WHERE numeroplan = '${numeroplan}';`;
    const res = await client.query(query);
    client.release();
    return res;
  }
}
