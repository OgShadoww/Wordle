# Wordle (ARM64 Assembly, macOS)

A work-in-progress **Wordle-like** game written in **ARM64 (AArch64) assembly** for **macOS on Apple Silicon (M-series)**.

This project is primarily a learning + systems exercise: implementing real program structure, state handling, and I/O close to the metal—without relying on a high-level runtime.

---

## Status

**WIP / in development.**  
Expect rough edges, incomplete features, and changing interfaces.

---

## Goals

- Build a playable Wordle-style game in pure ARM64 assembly
- Keep dependencies minimal and understand:
  - calling conventions
  - stack discipline and memory layout
  - syscalls / libc calls (depending on approach)
  - parsing and validation
  - game loop and state transitions
