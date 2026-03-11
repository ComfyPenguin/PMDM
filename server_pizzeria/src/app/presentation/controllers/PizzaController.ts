import { Request, Response } from "express";
import GetPizzesUseCase from "../../domain/use-cases/GetPizzesUseCase.js";
import PizzaRepositoryImpl from "../../infraestructure/repositories/PizzaRepositoryImpl.js";

export default class PizzaController {
    
    // Obtenir pizzes amb paginació
    static getPizzes(req: Request, res: Response): void {
        const pageNumber = parseInt(req.query.pageNumber as string);
        const pageSize = parseInt(req.query.pageSize as string);

        // Crear instància del repositori
        const pizzaRepository = new PizzaRepositoryImpl();

        // CAs d'us per a obtindre pizzes
        const getPizzesUseCase = new GetPizzesUseCase(pizzaRepository);

        const pizzesResponse = getPizzesUseCase.execute(pageNumber, pageSize);

        res.status(200).json(pizzesResponse);
    }
}
