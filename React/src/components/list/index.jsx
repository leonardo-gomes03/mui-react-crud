/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable no-undef */
/* eslint-disable no-unused-vars */
import {
  Add,
  Delete,
  Edit,
  NavigateBefore,
  NavigateNext,
  PersonAddRounded,
  Search,
} from "@mui/icons-material";
import {
  Accordion,
  AccordionDetails,
  AccordionSummary,
  Avatar,
  Box,
  Button,
  Divider,
  Icon,
  IconButton,
  InputAdornment,
  List,
  ListItem,
  MenuItem,
  OutlinedInput,
  Paper,
  TextField,
  Typography,
} from "@mui/material";
import Image from "mui-image";
import { useEffect, useState } from "react";
import DeleteModal from "./confirmDelete";
import UserModal from "./userModal";

export default function ListItems() {
  const BaseURL = "http://localhost:9000";

  const [dados, setDados] = useState([]);
  const [page, setPage] = useState(1);
  const [userModal, setUserModal] = useState(false);
  const [deleteModal, setDeleteModal] = useState(false);
  const [deleteSequencia, setDeleteSequencia] = useState();
  const [deleteNome, setDeleteNome] = useState("");
  const [isEdit, setIsEdit] = useState(false);
  const [pageSize, setPageSize] = useState(10);
  const [searchNome, setSearchNome] = useState("");
  const [refresh, setRefresh] = useState(false);

  const [sequencia, setSequencia] = useState();
  const [nome, setNome] = useState("");
  const [rg, setRg] = useState("");
  const [cpf, setCpf] = useState("");
  const [sexo, setSexo] = useState("");
  const [datanascimento, setDatanascimento] = useState();
  const [foto, setFoto] = useState();

  const addPessoa = () => {
    setSequencia(null);
    setNome("");
    setRg("");
    setCpf("");
    setSexo("");
    setDatanascimento("");
    setFoto("");

    setIsEdit(false), setUserModal(true);
  };

  const editPessoa = (sequencia, nome, rg, cpf, sexo, datanascimento, foto) => {
    setSequencia(sequencia);
    setNome(nome);
    setRg(rg);
    setCpf(cpf);
    setSexo(sexo);
    setDatanascimento(datanascimento);
    setFoto(foto);

    setIsEdit(true), setUserModal(true);
  };

  const fetchAPI = async (pagina, nome) => {
    if (pagina < 1) {
      setPage(1);
      pagina = 1;
    }

    await fetch(
      BaseURL +
        `/pessoas/?` +
        `limit=` +
        pageSize +
        `&` +
        `page=` +
        pagina +
        `&` +
        "nome=" +
        nome,
      {
        method: "GET",
        headers: {
          "x-paginate": true,
          Authorization: "Basic " + btoa("admin:admin"),
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": true,
          "Access-Control-Allow-Headers": "*",
          "Access-Control-Allow-Methods": "*",
          "Access-Control-Expose-Headers": "*",
        },
      }
    ).then(async (response) => {
      const data = await response.json();
      if (pagina > data.pages) {
        setPage(data.pages);
        return;
      }
      setDados(data.docs);
    });
  };

  const trocaPageSize = (pageSize) => {
    setPageSize(pageSize);
  };

  useEffect(() => {
    fetchAPI(page, searchNome);
    setRefresh(false);
  }, [pageSize, searchNome, refresh]);

  return (
    <>
      <UserModal
        isEdit={isEdit}
        open={userModal}
        onClose={() => (setRefresh(true), setUserModal(false))}
        sequencia={sequencia}
        nome={nome}
        rg={rg}
        cpf={cpf}
        sexo={sexo}
        datanascimento={datanascimento}
        foto={foto}
      />
      <DeleteModal
        open={deleteModal}
        onClose={() => (setRefresh(true), setDeleteModal(false))}
        sequencia={deleteSequencia}
        nome={deleteNome}
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
          <form onSubmit={(e) => e.preventDefault()}>
            <OutlinedInput
              placeholder="Busca por nome"
              size="medium"
              variant="outlined"
              color="primary"
              onChange={(e) => {
                setPage(1);
                setSearchNome(e.target.value);
              }}
              sx={{ textAlign: "center", width: "40vw", minWidth: "300px" }}
              endAdornment={
                <Icon>
                  <Search />
                </Icon>
              }
            />
          </form>
          <IconButton onClick={() => addPessoa()}>
            <PersonAddRounded fontSize="large" color="success" />
          </IconButton>
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
                  marginBottom: 1,
                }}
              >
                <Box
                  sx={{
                    display: "flex",
                    gap: 2,
                    alignItems: "center",
                  }}
                >
                  <Avatar
                    width="50px"
                    src={"data:image;base64," + atob(el.foto)}
                  />
                  <Box>
                    <Box sx={{ display: "flex", gap: 1 }}>
                      <Typography>{el.nome}</Typography>
                      <Typography>{el.sequencia}</Typography>
                    </Box>
                    <Box sx={{ display: "flex", gap: 2 }}>
                      <Typography>RG: {el.rg}</Typography>
                      <Typography>CPF: {el.cpf}</Typography>
                      <Typography>Sexo: {el.sexo}</Typography>
                    </Box>
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
                        el.datanascimento,
                        el.foto
                      );
                    }}
                  >
                    <Edit />
                  </IconButton>
                  <IconButton
                    onClick={() => (
                      setDeleteModal(true),
                      setDeleteSequencia(el.sequencia),
                      setDeleteNome(el.nome)
                    )}
                  >
                    <Delete color="error" />
                  </IconButton>
                </Box>
              </Paper>
            ))
          : null}
        <Box
          sx={{
            display: "flex",
            justifyContent: "flex-end",
            alignItems: "center",
            marginTop: 2,
          }}
        >
          <TextField
            select
            type="number"
            size="small"
            defaultValue={10}
            label="Page size"
            onChange={(e) => trocaPageSize(e.target.value)}
          >
            <MenuItem key={0} value={10}>
              10
            </MenuItem>
            <MenuItem key={1} value={15}>
              15
            </MenuItem>
            <MenuItem key={2} value={25}>
              25
            </MenuItem>
          </TextField>
          <IconButton
            color="default"
            size="large"
            onClick={() => {
              setPage(page - 1), fetchAPI(page - 1, searchNome);
            }}
          >
            <NavigateBefore fontSize="medium" />
          </IconButton>
          <IconButton
            color="default"
            size="large"
            onClick={() => {
              fetchAPI(page + 1, searchNome), setPage(page + 1);
            }}
          >
            <NavigateNext fontSize="medium" />
          </IconButton>
        </Box>
      </Paper>
    </>
  );
}
