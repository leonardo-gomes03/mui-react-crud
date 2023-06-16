/* eslint-disable no-unused-vars */
import { Typography } from "@mui/material";
import { useEffect, useState } from "react";
import ListHeader from "./listheader";

export default function ListItems() {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetch(`https://localhost:9000/pessoas/3`)
      .then((response) => response.json())
      .then((actualData) => console.log(actualData))
      .catch((err) => {
        console.log(err.message);
      });
  }, []);
  return (
    <>
      <ListHeader />
      <Typography>List</Typography>
    </>
  );
}
