import { NextFunction, Request, Response, Router } from "express";
import { inject, injectable } from "inversify";
import * as pg from "pg";
import { Planrepas } from "../../../common/tables/Planrepas";

import { DatabaseService } from "../services/database.service";
import Types from "../types";

@injectable()
export class DatabaseController {
  public constructor(
    @inject(Types.DatabaseService) private databaseService: DatabaseService
  ) {}

  public get router(): Router {
    const router: Router = Router();

    // ======= HOTEL ROUTES =======
    // ex http://localhost:3000/database/hotel?hotelNb=3&name=LeGrandHotel&city=laval

    // ======= ROUTES Plan repas =======
    router.get("/planrepas", (req: Request, res: Response, next: NextFunction) => {
        this.databaseService
          .getAllPlanRepas(req.params.PlanRepas)
          .then((result: pg.QueryResult) => {
            const plans: Planrepas[] = result.rows.map((plan: Planrepas) => ({
              numeroplan: plan.numeroplan,
              categorie: plan.categorie,
              frequence: plan.frequence,
              nbrpersonnes: plan.nbrpersonnes,
              nbcalories: plan.nbcalories,
              prix: plan.prix,
              numerofournisseur: plan.numerofournisseur,
            }));
            res.json(plans);
          })
          .catch((e: Error) => {
            console.error(e.stack);
          });
      }
    );

    router.post(
      "/planrepas/insert",
      (req: Request, res: Response, _: NextFunction) => {
        const plan: Planrepas = {
          numeroplan: req.body.numeroplan,
          categorie: req.body.categorie,
          frequence: req.body.frequence,
          nbrpersonnes: req.body.nbrpersonnes,
          nbcalories: req.body.nbcalories,
          prix: req.body.prix,
          numerofournisseur: req.body.numerofournisseur,
        };

        this.databaseService
          .createPlan(plan)
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      }
    );

    router.put(
      "/planrepas/update",
      (req: Request, res: Response, _: NextFunction) => {
        const plan: Planrepas = {
          numeroplan: req.body.numeroplan,
          categorie: req.body.categorie,
          frequence: req.body.frequence,
          nbrpersonnes: req.body.nbrpersonnes,
          nbcalories: req.body.nbcalories,
          prix: req.body.prix,
          numerofournisseur: req.body.numerofournisseur,
        };
        this.databaseService
          .updatePlan(plan)
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      }
    );

    router.post(
      "/planrepas/delete/:numeroplan",
      (req: Request, res: Response, _: NextFunction) => {
        const numeroplan: string = req.params.numeroplan;

        this.databaseService
          .deletePlan(numeroplan)
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      }
    );

    return router;
  }

}
