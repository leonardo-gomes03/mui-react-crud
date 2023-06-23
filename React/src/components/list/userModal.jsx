/* eslint-disable no-undef */
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
import { useForm } from "react-hook-form";

export default function UserModal(props) {
  const [isEdit, setIsEdit] = useState(false);

  const { onClose } = props;

  const pessoa = {
    sequencia: props.sequencia,
    nome: props.nome,
    rg: props.rg,
    cpf: props.cpf,
    sexo: props.sexo,
    datanascimento: props.datanascimento,
  };

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm();

  //função close modal
  const handleClose = () => {
    onClose(true);
  };

  const onSubmit = (data) => {
    //Valida se é mudança
    if (isEdit == true) {
      //Altera
      //valida de mudança
      for (var item in data) {
        if (data[item] == "") {
          data[item] = pessoa[item];
        }
      }

      //envia pra api
      fetch(`http://localhost:9000/pessoas/` + props.sequencia, {
        method: "PATCH",
        headers: {
          "x-paginate": true,
          Authorization: "Basic " + btoa("admin:admin"),
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": true,
          "Access-Control-Allow-Headers": "*",
          "Access-Control-Allow-Methods": "*",
          "Access-Control-Expose-Headers": "*",
        },
        body: JSON.stringify(data),
      });

      //fecha modal
      handleClose();
    } else {
      //Insere
      data.sequencia = null;

      fetch(`http://localhost:9000/pessoas`, {
        method: "POST",
        headers: {
          "x-paginate": true,
          Authorization: "Basic " + btoa("admin:admin"),
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": true,
          "Access-Control-Allow-Headers": "*",
          "Access-Control-Allow-Methods": "*",
          "Access-Control-Expose-Headers": "*",
        },
        body: JSON.stringify(data),
      });

      //fecha modal
      handleClose();
    }
  };

  useEffect(() => {
    setIsEdit(props.isEdit);
    return () => {};
  });

  return (
    <>
      <Dialog open={props.open} onClose={onClose}>
        <DialogTitle>
          {isEdit ? (
            <Typography>Editar Usuario{": " + pessoa.nome}</Typography>
          ) : (
            <Typography>Adicionar Usuario</Typography>
          )}
        </DialogTitle>
        <DialogContent>
          <form onSubmit={handleSubmit(onSubmit)} autoComplete="off">
            <Box
              sx={{
                display: "flex",
                flexDirection: "column",
                gap: 2,
                alignItems: "end",
              }}
            >
              <TextField
                type="text"
                placeholder="nome"
                {...register("nome", { required: true, maxLength: 50 })}
              />
              <TextField
                type="text"
                placeholder="rg"
                {...register("rg", { maxLength: 11 })}
              />
              <TextField
                type="text"
                placeholder="cpf"
                {...register("cpf", { maxLength: 11 })}
              />
              <TextField
                type="text"
                placeholder="datanascimento"
                {...register("datanascimento", {
                  maxLength: 11,
                })}
              />
              <TextField
                type="text"
                placeholder="sexo"
                {...register("sexo", { maxLength: 1 })}
              />
              <Button variant="contained" type="submit">
                Enviar
              </Button>
            </Box>
          </form>
        </DialogContent>
      </Dialog>
    </>
  );
}
