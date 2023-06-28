import { Trash, X } from '@tamagui/lucide-icons'
import { useState } from 'react'
import {
  Adapt,
  Button,
  Dialog,
  Fieldset,
  Input,
  Label,
  Paragraph,
  Sheet,
  TooltipSimple,
  Unspaced,
  XStack,
  YStack,
} from 'tamagui'

export function DialogDelete(props) {
  const [open, setOpen] = useState(false)
  return (
    <Dialog
      modal
      onOpenChange={(open) => {
        setOpen(open)
      }}
    >
      <Dialog.Trigger asChild>
        <Button
          icon={Trash}
          color={'$red10Dark'}
          alignSelf="flex-end"
          size="$4.5"
          circular
          chromeless
        />
      </Dialog.Trigger>

      {/* <Adapt when="sm" platform="touch">
        <Sheet zIndex={200000} modal dismissOnSnapToBottom>
          <Sheet.Frame padding="$4" space  >
            <Adapt.Contents />
          </Sheet.Frame>
          <Sheet.Overlay />
        </Sheet>
      </Adapt> */}

      <Dialog.Portal>
        <Dialog.Overlay
          key="overlay"
          animation="quick"
          opacity={0.5}
          enterStyle={{ opacity: 0 }}
          exitStyle={{ opacity: 0 }}
        />

        <Dialog.Content
          bordered
          elevate
          key="content"
          animation={[
            'quick',
            {
              opacity: {
                overshootClamping: true,
              },
            },
          ]}
          enterStyle={{ x: 0, y: -20, opacity: 0, scale: 0.9 }}
          exitStyle={{ x: 0, y: 10, opacity: 0, scale: 0.95 }}
          space
        >
          <Dialog.Title>Deletar Usuario</Dialog.Title>
          <Dialog.Description>Deseja deletar o usuário {props.nome}?</Dialog.Description>

          <XStack alignSelf="flex-end" space>
            <Dialog.Close displayWhenAdapted asChild>
              <Button theme="alt1" aria-label="Close">
                Cancelar
              </Button>
            </Dialog.Close>

            <Dialog.Close displayWhenAdapted asChild>
              <Button backgroundColor="$red11Dark" color="$red1Dark" aria-label="Close">
                Deletar
              </Button>
            </Dialog.Close>
          </XStack>
        </Dialog.Content>
      </Dialog.Portal>
    </Dialog>
  )
}
