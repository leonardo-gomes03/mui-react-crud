/* eslint-disable no-undef */
/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable no-unused-vars */
/* eslint-disable no-const-assign */
/* eslint-disable react/prop-types */

import {
  Avatar,
  Box,
  Button,
  Dialog,
  DialogContent,
  DialogTitle,
  Divider,
  Input,
  MenuItem,
  TextField,
  Typography,
} from "@mui/material";
import { useEffect, useState } from "react";
import { useForm } from "react-hook-form";

const fileToDataUri = (file) =>
  new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = (event) => {
      resolve(event.target.result);
    };
    reader.readAsDataURL(file);
  });

export default function UserModal(props) {
  const BaseURL = "http://localhost:9000";

  const [isEdit, setIsEdit] = useState(false);
  const [placeholder, setPlaceholder] = useState("");
  const [image, setImage] = useState("");

  const onImageChange = (file) => {
    if (!file) {
      setImage("");
      return;
    }
    fileToDataUri(file).then((image) => {
      const converted = image.replace("data:image/png;base64,", "");
      setImage(converted);
    });
  };

  const { onClose } = props;

  const pessoa = {
    sequencia: props.sequencia,
    nome: props.nome,
    rg: props.rg,
    cpf: props.cpf,
    sexo: props.sexo,
    datanascimento: props.datanascimento,
    foto: props.foto,
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

      // const binaryString = atob(image.replace("data:image/png;base64,", "")); // Binary data string
      data.foto = image;

      // envia pra api
      fetch(BaseURL + `/pessoas/` + props.sequencia, {
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

      // console.log(data);
      //fecha modal
      handleClose();
    } else {
      //Insere
      data.sequencia = null;

      fetch(BaseURL + `/pessoas/`, {
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
    setImage("");

    if (props.foto != undefined) {
      setPlaceholder("data:image/png;base64," + atob(props.foto));
    } else {
      setPlaceholder("");
    }
  }, [props.sequencia]);
  return (
    <>
      <Dialog open={props.open} onClose={onClose}>
        <DialogTitle textAlign={"center"}>
          {isEdit ? (
            <Typography>Editar Usuario{": " + pessoa.nome}</Typography>
          ) : (
            <Typography>Adicionar Usuario</Typography>
          )}
        </DialogTitle>
        <DialogContent>
          <Divider sx={{ marginBottom: 3 }} variant="fullWidth" />
          <form onSubmit={handleSubmit(onSubmit)} autoComplete="off">
            <Box
              sx={{
                display: "flex",
                flexDirection: "row",
                gap: 5,
                alignItems: "center",
              }}
            >
              <Box
                sx={{
                  display: "flex",
                  flexDirection: "column",
                  gap: 2,
                  alignItems: "center",
                }}
              >
                <Avatar
                  sx={{
                    width: "200px",
                    height: "200px",
                  }}
                  src={placeholder}
                />
                <Input
                  type="file"
                  onChange={(e) => {
                    onImageChange(e.target.files[0] || null);
                    fileToDataUri(e.target.files[0]).then((res) =>
                      setPlaceholder(res)
                    );
                  }}
                  fullWidth
                />
              </Box>
              <Box
                sx={{
                  display: "flex",
                  flexDirection: "column",
                  gap: 2,
                  alignItems: "flex-end",
                }}
              >
                <TextField
                  type="text"
                  placeholder="nome"
                  {...register("nome", { required: true, maxLength: 50 })}
                  fullWidth
                />
                <TextField
                  type="text"
                  placeholder="rg"
                  {...register("rg", { maxLength: 11 })}
                  fullWidth
                />
                <TextField
                  type="text"
                  placeholder="cpf"
                  {...register("cpf", { maxLength: 11 })}
                  fullWidth
                />
                <TextField
                  type="text"
                  placeholder="datanascimento"
                  {...register("datanascimento", {
                    maxLength: 11,
                  })}
                  fullWidth
                />
                <TextField
                  type="text"
                  placeholder="sexo"
                  select
                  defaultValue={props.sexo}
                  fullWidth
                  {...register("sexo", { maxLength: 1 })}
                >
                  <MenuItem key={"M"} value={"M"}>
                    Masculino
                  </MenuItem>
                  <MenuItem key={"F"} value={"F"}>
                    Feminino
                  </MenuItem>
                </TextField>
                <Button variant="contained" type="submit">
                  Enviar
                </Button>
              </Box>
            </Box>
          </form>
        </DialogContent>
      </Dialog>
    </>
  );
}
