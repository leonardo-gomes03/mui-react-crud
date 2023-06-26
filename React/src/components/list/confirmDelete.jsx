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
export default function DeleteModal(props) {
  const { onClose } = props;

  const deletarPessoa = (sequencia) => {
    const BaseURL = "http://localhost:8077/apiHorseDLL.dll";
    fetch(BaseURL + `/pessoas/` + sequencia, {
      method: "DELETE",
      headers: {
        Authorization: "Basic" + btoa("admin:admin"),
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": true,
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "*",
        "Access-Control-Expose-Headers": "*",
      },
    });
  };

  const handleClose = () => {
    onClose(true);
  };

  return (
    <>
      <Dialog open={props.open} onClose={props.onClose}>
        <DialogTitle>Deseja deletar a pessoa: {props.nome}?</DialogTitle>
        <DialogContent
          sx={{
            display: "flex",
            justifyContent: "space-between",
          }}
        >
          <Button
            variant="outlined"
            color="success"
            onClick={() => handleClose()}
          >
            Cancelar
          </Button>
          <Button
            variant="contained"
            color="error"
            onClick={() => (deletarPessoa(props.sequencia), handleClose())}
          >
            Excluir
          </Button>
        </DialogContent>
      </Dialog>
    </>
  );
}
