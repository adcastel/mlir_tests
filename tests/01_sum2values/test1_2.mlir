module {
  func.func @abc(%arg0: i32, %arg1: i32) -> i32 {
    %0 = emitc.cast %arg0 : i32 to ui32
    %1 = emitc.cast %arg1 : i32 to ui32
    %2 = emitc.add %0, %1 : (ui32, ui32) -> ui32
    %3 = emitc.cast %2 : ui32 to i32
    return %3 : i32
  }
}

