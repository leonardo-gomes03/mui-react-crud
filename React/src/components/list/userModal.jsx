/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable no-unused-vars */
/* eslint-disable no-const-assign */
/* eslint-disable react/prop-types */

import {
  Box,
  Button,
  Dialog,
  DialogContent,
  DialogTitle,
  TextField,
  Typography,
} from "@mui/material";
import { useEffect, useState } from "react";
import { Controller, useForm } from "react-hook-form";

export default function UserModal(props) {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm();

  const onSubmit = (data) => {
    data.sequencia = parseInt(data.sequencia, 10);
    console.log(data);

    fetch(`http://localhost:9000/pessoas`, {
      method: "POST",
      body: JSON.stringify(data),
    });
  };

  const [isEdit, setIsEdit] = useState(false);

  useEffect(() => {
    setIsEdit(props.isEdit);
  });

  console.log(isEdit);

  return (
    <>
      <Dialog open={props.open} onClose={props.onClose}>
        <DialogTitle>
          {isEdit ? (
            <Typography>Editar Usuario</Typography>
          ) : (
            <Typography>Adicionar Usuario</Typography>
          )}
        </DialogTitle>
        <DialogContent>
          <form onSubmit={handleSubmit(onSubmit)}>
            <Box
              sx={{
                display: "flex",
                flexDirection: "column",
                gap: 2,
                alignItems: "end",
              }}
            >
              <TextField
                type="number"
                placeholder="sequencia"
                {...register("sequencia", {
                  required: true,
                  min: 1,
                })}
              />

              <TextField
                type="text"
                placeholder="nome"
                {...register("nome", { required: true, maxLength: 50 })}
              />
              <TextField
                type="text"
                placeholder="rg"
                {...register("rg", { required: true, maxLength: 11 })}
              />
              <TextField
                type="text"
                placeholder="cpf"
                {...register("cpf", { required: true, maxLength: 11 })}
              />
              <TextField
                type="text"
                placeholder="datanascimento"
                {...register("datanascimento", {
                  required: true,
                  maxLength: 11,
                })}
              />
              <TextField
                type="text"
                placeholder="sexo"
                {...register("sexo", { required: true, maxLength: 11 })}
              />
              <Button type="submit">Enviar</Button>
            </Box>
          </form>
        </DialogContent>
      </Dialog>
    </>
  );
}
