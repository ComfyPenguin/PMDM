import { Router } from "express";
import PizzaController from "../controllers/PizzaController.js";

const pizzaRouter = Router();

// GET /pizzes
pizzaRouter.get("/pizzes", PizzaController.getPizzes);

export default pizzaRouter;

