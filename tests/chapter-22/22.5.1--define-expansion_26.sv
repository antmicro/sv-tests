// Copyright (C) 2019-2021  The SymbiFlow Authors.
//
// Use of this source code is governed by a ISC-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/ISC
//
// SPDX-License-Identifier: ISC


/*
:name: 22.5.1--define_expansion_26
:description: Test
:tags: 22.5.1
:type: preprocessing
*/
`define append(f) f``_master
module top ();
initial $display(`append(clock));
endmodule
