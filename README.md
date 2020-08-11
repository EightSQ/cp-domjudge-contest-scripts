# domjudge submit shell scripts

Some shell scripts for DOMjudge contest cloning and submissions (as a participant).
This probably works primarily on Linux and macOS.

## Prerequisites

You wil need
- `curl`
- `httpie`
- `xdg-open` (optional)

## Configuration

Create the following files.

- `$HOME/.config/domjudge/session` containing your *PHPSESSID* cookie
- `$HOME/.config/domjudge/judgeurl` containing the base url of the DOMjudge instance.

## Usage

Go to an appropriate directory and run `clone_contest.sh` there with a contest id as argument. E.g., can find it in the `domjudge_cid` cookie in your browser. This will create one directory for each problem.

Being in such problem directory and having a solution source file like e.g. `solution.cpp`, run `submit.sh` with the source file as argument. Do not remove the `.contest` and `.problem` files, they are needed by the `submit.sh` script.


## Customization

To add more languages, you will need to find their judge submission form values (i.e. **cpp17** for C++) and modify `submit.sh` accordingly.

There is a callback for the creation of each problem directory in `clone_contest.sh` script.
