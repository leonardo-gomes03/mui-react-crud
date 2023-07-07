import {
  Anchor,
  Avatar,
  Button,
  H1,
  Input,
  ListItem,
  Paragraph,
  ScrollView,
  Separator,
  Sheet,
  Text,
  useToastController,
  XStack,
  YGroup,
  YStack,
} from '@my/ui'
import { ChevronDown, ChevronUp, Edit, Plus, Trash, UserPlus } from '@tamagui/lucide-icons'
import React, { useEffect, useState } from 'react'
import { useLink } from 'solito/link'
import { DialogAdd } from './addScreen'
import { DialogDelete } from './deleteModal'
import { DialogEdit } from './editScreen'
export function HomeScreen() {
  const linkProps = useLink({
    href: '/user/nate',
  })
  const dados = [
    {
      sequencia: 18,
      nome: 'Alice Lopes',
      rg: '57567942',
      cpf: '41446664944',
      sexo: 'F',
      datanascimento: '1986-02-12',
      foto: null,
    },
    {
      sequencia: 19,
      nome: 'Alice Vieira',
      rg: '76457744',
      cpf: '41778993366',
      sexo: 'F',
      datanascimento: '1997-05-10',
      foto: null,
    },
    {
      sequencia: 20,
      nome: 'Alice Souza',
      rg: '67527988',
      cpf: '97260904333',
      sexo: 'F',
      datanascimento: '1985-02-26',
      foto: null,
    },
    {
      sequencia: 21,
      nome: 'Alice Fernandes',
      rg: '38653602',
      cpf: '30505473104',
      sexo: 'F',
      datanascimento: '1995-03-16',
      foto: null,
    },
    {
      sequencia: 22,
      nome: 'Alice Lima',
      rg: '16997075',
      cpf: '24952157840',
      sexo: 'F',
      datanascimento: '2004-05-06',
      foto: null,
    },
    {
      sequencia: 23,
      nome: 'Alice Costa',
      rg: '60008129',
      cpf: '17210299004',
      sexo: 'F',
      datanascimento: '1967-06-05',
      foto: null,
    },
    {
      sequencia: 24,
      nome: 'Alice Batista',
      rg: '1060740',
      cpf: '62039768371',
      sexo: 'F',
      datanascimento: '2000-02-16',
      foto: null,
    },
    {
      sequencia: 25,
      nome: 'Alice Dias',
      rg: '68280716',
      cpf: '19498483199',
      sexo: 'F',
      datanascimento: '1969-12-02',
      foto: null,
    },
    {
      sequencia: 26,
      nome: 'Alice Moreira',
      rg: '43768609',
      cpf: '96247068463',
      sexo: 'F',
      datanascimento: '1997-07-29',
      foto: null,
    },
    {
      sequencia: 27,
      nome: 'Alice de Lima',
      rg: '47852078',
      cpf: '82541701136',
      sexo: 'F',
      datanascimento: '1987-07-08',
      foto: null,
    },
    {
      sequencia: 18,
      nome: 'Alice Lopes',
      rg: '57567942',
      cpf: '41446664944',
      sexo: 'F',
      datanascimento: '1986-02-12',
      foto: null,
    },
    {
      sequencia: 19,
      nome: 'Alice Vieira',
      rg: '76457744',
      cpf: '41778993366',
      sexo: 'F',
      datanascimento: '1997-05-10',
      foto: null,
    },
    {
      sequencia: 20,
      nome: 'Alice Souza',
      rg: '67527988',
      cpf: '97260904333',
      sexo: 'F',
      datanascimento: '1985-02-26',
      foto: null,
    },
    {
      sequencia: 21,
      nome: 'Alice Fernandes',
      rg: '38653602',
      cpf: '30505473104',
      sexo: 'F',
      datanascimento: '1995-03-16',
      foto: null,
    },
    {
      sequencia: 22,
      nome: 'Alice Lima',
      rg: '16997075',
      cpf: '24952157840',
      sexo: 'F',
      datanascimento: '2004-05-06',
      foto: null,
    },
    {
      sequencia: 23,
      nome: 'Alice Costa',
      rg: '60008129',
      cpf: '17210299004',
      sexo: 'F',
      datanascimento: '1967-06-05',
      foto: null,
    },
    {
      sequencia: 24,
      nome: 'Alice Batista',
      rg: '1060740',
      cpf: '62039768371',
      sexo: 'F',
      datanascimento: '2000-02-16',
      foto: null,
    },
    {
      sequencia: 25,
      nome: 'Alice Dias',
      rg: '68280716',
      cpf: '19498483199',
      sexo: 'F',
      datanascimento: '1969-12-02',
      foto: null,
    },
    {
      sequencia: 26,
      nome: 'Alice Moreira',
      rg: '43768609',
      cpf: '96247068463',
      sexo: 'F',
      datanascimento: '1997-07-29',
      foto: null,
    },
    {
      sequencia: 27,
      nome: 'Alice de Lima',
      rg: '47852078',
      cpf: '82541701136',
      sexo: 'F',
      datanascimento: '1987-07-08',
      foto: null,
    },
  ]

  return (
    <YStack marginBottom="$12">
      <XStack marginVertical="$3" marginHorizontal="$2" gap="$4">
        <Input size="$4" f={1} />
      </XStack>

      <ScrollView>
        <YGroup separator={<Separator />}>
          {dados.map((el, index) => (
            <YGroup.Item key={index}>
              <XStack paddingVertical={8}>
                <ListItem hoverTheme>
                  <XStack gap={12}>
                    <Avatar marginLeft="$3" circular size="$4">
                      <Avatar.Image src="http://placekitten.com/200/300" />
                      <Avatar.Fallback bc="$gray6" />
                    </Avatar>

                    <YStack start={1}>
                      <Text>{el.nome}</Text>
                      <Text>{el.datanascimento}</Text>
                    </YStack>
                  </XStack>

                  <XStack gap="$1">
                    <DialogEdit nome={el.nome} />
                    <DialogDelete nome={el.nome} />
                  </XStack>
                </ListItem>
              </XStack>
            </YGroup.Item>
          ))}
        </YGroup>
      </ScrollView>

      <DialogAdd />
    </YStack>
  )
}
