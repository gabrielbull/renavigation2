import { NativeHistory, State } from '@renavigation2/history'
import { useContext } from 'react'
import invariant from 'tiny-invariant'
import { NavigationNavigatorContext } from '../context/NavigationNavigatorContext'

export function useNavigation<S extends State = State>(): NativeHistory<S> {
  const context = useContext(NavigationNavigatorContext)!
  invariant(
    context && context.navigator,
    'You should not use useNavigation outside a <NavigationRouter>'
  )
  return context!.navigator! as NativeHistory<S>
}
