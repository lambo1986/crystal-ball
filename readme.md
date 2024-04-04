# Welcome to Crystal Ball!
***This was a fun experiment meant to help myself learn the language Crystal, 
but it resulted in an amazing and magical fortune-telling device!***
# Prerequisites
- Before you begin, ensure you have Crystal installed on your system. You can find installation instructions on the official [Crystal website](https://crystal-lang.org/). Or if you have Homebrew installed, you can run:

```
brew install crystal
```

# First: Clone the Repo
- Fork and Clone this repo to your computer.
# Then: Compile the Program
- Open your terminal and navigate to the root directory of your project where the main Crystal file (main.cr) is located. Compile the program using the Crystal compiler with the following command:

```
crystal build main.cr -o fortune_teller
```

- This command compiles main.cr into an executable named fortune_teller. The -o option specifies the output filename for the compiled executable.

# And Then: Run the FortuneTeller
- After compiling, you can run the executable to see your incredible fortune:

```
./fortune_teller
```

- This command executes the fortune_teller binary, which prints a random fortune to your terminal.

# To kill the music after the game is over:

```
pkill afplay
```

- Note: The music will also end when the song is over, or you can rerun the program and press any key besides "y" at the first prompt to kill the music.

***Have Fun,<br>
Nathan Kirk Lambertson***
