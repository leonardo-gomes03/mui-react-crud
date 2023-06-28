import { ToastViewport as ToastViewportOg } from '@my/ui'
import { useSafeAreaInsets } from 'react-native-safe-area-context'

export const ToastViewport = () => {
  const { top, right, left, bottom } = useSafeAreaInsets()
  return <ToastViewportOg top={top + 5} left={left} right={right} bottom={bottom + 200} />
}
