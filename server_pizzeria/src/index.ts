import express from "express";
import path from "path";
import { fileURLToPath } from "url";
import pizzaRouter from "./app/presentation/routes/PizzaRouter.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
app.use(express.json());

// SErveix les imatges des de la carpeta public
app.use(express.static(path.join(__dirname, "../public")));

// Us de l'API
app.use("/api/pizzeria", pizzaRouter);

// Iniciar servidor
app.listen(3000, () => {
    console.log(`http://127.0.0.1:3000/api/pizzeria`);
});

export default app;
