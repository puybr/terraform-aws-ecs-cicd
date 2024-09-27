import express from "express";
import "dotenv/config";

const app = express();
const port = process.env.APPLICATION_PORT;

app.get('/', (req, res) => {
  res.send(`Congratulations! 🎉 Your "${process.env.APPLICATION_NAME}" server has been deployed successfully on port ${process.env.APPLICATION_PORT}! ENVVAR: ${process.env.ENVVAR}!!! SECRET: ${process.env.SECRET}!!!`);
});

app.listen(port, () => {
  console.log(`Server is running on port ${process.env.APPLICATION_PORT}`);
});
