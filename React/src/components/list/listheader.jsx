/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable no-undef */
/* eslint-disable no-unused-vars */
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Box,
  Button,
  Divider,
  List,
  ListItem,
  Paper,
  TextField,
  Typography,
} from "@mui/material";
import { useEffect, useState } from "react";
import UserModal from "./userModal";

export default function ListHeader() {
  const [dados, setDados] = useState([]);
  const [page, setPage] = useState(1);
  const [userModal, setUserModal] = useState(false);
  const [isEdit, setIsEdit] = useState(false);

  const fetchAPI = (pagina) => {
    if (pagina < 1) {
      setPage(1);
      pagina = 1;
    }
    fetch(`http://localhost:9000/pessoas/?limit=10&page=` + pagina, {
      method: "GET",
      headers: {
        "x-paginate": true,
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": true,
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "*",
        "Access-Control-Expose-Headers": "*",
      },
    }).then(async (response) => {
      const data = await response.json();
      if (pagina > data.pages) {
        setPage(data.pages);
        return;
      }
      setDados(data.docs);
    });
  };

  const deletarPessoa = (sequencia) => {
    fetch(`http://localhost:9000/pessoas/` + sequencia, {
      method: "DELETE",
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": true,
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Allow-Methods": "*",
        "Access-Control-Expose-Headers": "*",
      },
    });
    fetchAPI(page);
  };
  return (
    <>
      <UserModal
        isEdit={isEdit}
        open={userModal}
        onClose={() => setUserModal(false)}
      />
      <Paper
        elevation={16}
        sx={{ gap: 2, padding: 2, paddingTop: 1 }}
        variant="elevation"
      >
        <Box
          sx={{
            marginY: 2,
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
            gap: 1,
          }}
        >
          <TextField
            placeholder="Busca por nome"
            size="medium"
            variant="outlined"
            color="primary"
            fullWidth
            sx={{ textAlign: "center" }}
          />
          <Button
            variant="outlined"
            color="success"
            sx={{ height: "" }}
            onClick={() => (setIsEdit(false), setUserModal(true))}
          >
            <Typography>Adicionar Pessoa</Typography>
          </Button>
        </Box>

        {dados.length > 0
          ? dados.map((el, index) => (
              <Paper
                elevation={0}
                key={index}
                sx={{
                  display: "flex",
                  justifyContent: "space-between",
                  alignItems: "center",
                }}
              >
                <Box>
                  <Box sx={{ display: "flex", gap: 2 }}>
                    <Typography>{el.sequencia}</Typography>
                    <Typography>{el.nome}</Typography>
                  </Box>
                  <Box sx={{ display: "flex", gap: 2 }}>
                    <Typography>RG: {el.rg}</Typography>
                    <Typography>CPF: {el.cpf}</Typography>
                    <Typography>Sexo: {el.sexo}</Typography>
                  </Box>
                </Box>
                <Box>
                  <Button
                    onClick={() => {
                      setIsEdit(true), setUserModal(true);
                    }}
                  >
                    Edt
                  </Button>
                  <Button onClick={() => deletarPessoa(el.sequencia)}>
                    Exc
                  </Button>
                </Box>
              </Paper>
            ))
          : null}
        <Box
          sx={{
            display: "flex",
            justifyContent: "space-between",
            marginTop: 2,
          }}
        >
          <Button
            variant="contained"
            color="primary"
            onClick={() => {
              setPage(page - 1), fetchAPI(page - 1);
            }}
          >
            Pagina Anterior
          </Button>
          <Button
            variant="contained"
            color="primary"
            onClick={() => {
              fetchAPI(page + 1), setPage(page + 1);
            }}
          >
            Proxima Pagina
          </Button>
        </Box>
      </Paper>
    </>
  );
}
