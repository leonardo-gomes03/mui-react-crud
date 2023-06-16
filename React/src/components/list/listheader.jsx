/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable no-undef */
/* eslint-disable no-unused-vars */
import { Delete, Edit } from "@mui/icons-material";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Box,
  Button,
  Divider,
  Icon,
  IconButton,
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

  const [sequencia, setSequencia] = useState();
  const [nome, setNome] = useState("");
  const [rg, setRg] = useState("");
  const [cpf, setCpf] = useState("");
  const [sexo, setSexo] = useState("");
  const [datanascimento, setDatanascimento] = useState();

  const addPessoa = () => {
    setSequencia(null);
    setNome("");
    setRg("");
    setCpf("");
    setSexo("");
    setDatanascimento("");

    setIsEdit(false), setUserModal(true);
  };

  const editPessoa = (sequencia, nome, rg, cpf, sexo, datanascimento) => {
    setSequencia(sequencia);
    setNome(nome);
    setRg(rg);
    setCpf(cpf);
    setSexo(sexo);
    setDatanascimento(datanascimento);

    setIsEdit(true), setUserModal(true);
  };

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
        onClose={() => (fetchAPI(page), setUserModal(false))}
        sequencia={sequencia}
        nome={nome}
        rg={rg}
        cpf={cpf}
        sexo={sexo}
        datanascimento={datanascimento}
        // foto={foto}
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
            onClick={() => addPessoa()}
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
                <Box paddingLeft={5}>
                  <IconButton
                    onClick={() => {
                      editPessoa(
                        el.sequencia,
                        el.nome,
                        el.rg,
                        el.cpf,
                        el.sexo,
                        el.datanascimento
                      );
                    }}
                  >
                    <Edit />
                  </IconButton>
                  <IconButton onClick={() => deletarPessoa(el.sequencia)}>
                    <Delete color="error" />
                  </IconButton>
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
