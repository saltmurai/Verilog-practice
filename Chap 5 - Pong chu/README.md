# Alternate debouncing circuit

One problem with the debouncing design in Section 5.3.2 is the delayed response of the
onset of a switch transition. An alternative is to react to the first edge in the transition and
then wait for a small amount of time (at least 20 ms) to have the input signal settled. The
output timing diagram is shown at the bottom of Figure 5.8. When the input changes from 0 to 1, the FSM responds immediately. The FSM then ignores the input for about 20 ms to
avoid glitches. After this amount of time, the FSM starts to check the input for the falling
edge. Follow the design procedure in Section 5.3.2 to design the alternative circuit.
1. Derive the state diagram and ASM chart for the circuit.
2. Derive the HDL code.
3. Derive the HDL code based on the state diagram and ASM chart.
4. Derive a testbench and use simulation to verify operation of the code.
5. Replace the debouncing circuit in Section 5.3.3 with the alternative design and verify
its operation
