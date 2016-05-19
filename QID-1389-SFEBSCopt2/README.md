
[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="880" alt="Visit QuantNet">](http://quantlet.de/index.php?p=info)

## [<img src="https://github.com/QuantLet/Styleguide-and-Validation-procedure/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFEBSCopt2**[<img src="https://github.com/QuantLet/Styleguide-and-Validation-procedure/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/d3/ia)

```yaml
Name of QuantLet: SFEBSCopt2

Published in: Statistics of Financial Markets

Description: 'Computes the Black-Scholes price of a European call option. Optionally, option parameters may be given interactively as user input.'

Keywords: 'asset, black-scholes, call, european-option, financial, option, option-price, normal approximation, normal-distribution, option'

See also: SFEBSCopt1, SFENormalApprox1, SFENormalApprox2, SFENormalApprox3, SFENormalApprox4

Author: Felix Jung

Author[Maltab]: Wolfgang Karl Haerdle

Submitted: Tue, May 17 2016 by Christoph Schult

Example: 'For [spot price, strike price, interest rate] = [98, 100, 0.05],[cost of carry b, volatility sig, tau]= [0.05, 0.20, 20/52], the price of the European call option is given.'

```



### R Code:
```r

# clear variables and close windows
rm(list = ls(all = TRUE))
graphics.off()

ReadConsoleInput = function(prompt.message, bounds) {
    input = NA
    while (!is.numeric(input)) {
        input = as.numeric(sub(",", ".", readline(prompt = prompt.message)))
        if (!missing(bounds)) {
            if (length(bounds) > 1) {
                if (input < bounds[1] | input > bounds[2]) {
                  input = NA
                  cat("Error: value must lie between", bounds[1], "and", bounds[2], 
                    "n")
                }
            } else {
                if (input < bounds[1]) {
                  input = NA
                  cat("Error: value must lie at or above", bounds[1], "n")
                }
            }
        }
    } 
    return(input)
}

# Set defaults
K   = 100
S   = 98
r   = 1/20
b   = 1/20
tau = 20/52
sig = 1/5

# Check whether user wants to use defaults
use.defaults = TRUE
cat("The default option parameters are:n")
cat("S =", S, "n")
cat("K =", K, "n")
cat("r =", r, "n")
cat("b =", b, "n")
cat("tau =", tau, "n")
cat("sig =", sig, "n")

while (TRUE) {
    user.input = readline("Would you like to use these default values (y/n)? ")
    if (!(user.input %in% c("y", "n"))) {
        cat("Invalid input: please use y or n to answer the question.n")
    } else {
        if (user.input == "y") {
            use.defaults = TRUE
        } else {
            use.defaults = FALSE
        }
        break
    }
}

if (use.defaults == FALSE) {
    S   = ReadConsoleInput("Please enter a stock price S: ", bounds = c(0))
    K   = ReadConsoleInput("Please enter a strike price K: ", bounds = c(0))
    r   = ReadConsoleInput("Please enter the risk free rate r: ", bounds = c(0))
    b   = ReadConsoleInput("Please enter the cost of carry b: ", bounds = c(-1, 1))
    sig = ReadConsoleInput("Please enter the stock price volatility sigma: ", bounds = c(0))
    tau = ReadConsoleInput("Please enter the time to maturity tau: ", bounds = c(0))
}

set.seed(0)

# Main computation
y = (log(S/K) + (b - (sig^2)/2) * tau)/(sig * sqrt(tau))
c = exp(-(r - b) * tau) * S * pnorm(y + sig * sqrt(tau)) - exp(-r * tau) * K * 
    pnorm(y)

# Output
cat("Price of the European Call: ")
cat(formatC(c, format = "f", digits = 4), "n")
```
### Matlab Code
```matlab
clear
clc
close all

% User inputs parameters

disp('Please input spot S, strike K, and interest r as: [98, 100, 0.05]') ;
disp(' ') ;
para = input('[spot price, strike price, interest rate] = ');

while length(para) < 3
    disp('Not enough input arguments. Please input in 1*3 vector form like [98, 100, 0.05] or [98 100 0.05]');
    para = input('[spot price, strike price, interest rate] = ');
end

% spot price
S = para(1);

% strike price
K = para(2);

% interest rate
r = para(3);

disp(' ') ;
disp('Please input cost of carry b, and volatility sig, remaining time tau as: [0.05, 0.20, 20/52]') ;
disp(' ') ;
para2 = input('[cost of carry b, volatility sig, tau] = ') ;

while length(para2) < 3
    disp('Not enough input arguments. Please input in 1*3 vector form like [0.05, 0.20, 20/52] or [0.05 0.20 20/52]');
    para2 = input('[cost of carry b, volatility sig, tau]=');
end

% cost of carry, volatility, remaining time
b   = para2(1);
sig = para2(2);
tau = para2(3);

% Main computation
y = (log(S / K) + (b - (sig^2) / 2) * tau) / (sig * sqrt(tau));
c = exp(-(r - b) * tau) * S * normcdf(y + sig * sqrt(tau)) - exp(-r * tau) * K * normcdf(y);

% Output

disp(' ') ;
disp('Asset price S = ')
disp(S)
disp('Strike K = ')
disp(K)
disp('Interest rate r = ')
disp(r)
disp('Costs of carry b = ')
disp(b)
disp('Volatility sigma = ')
disp(sig)
disp('Time to expiration tau = ')
disp(tau)
disp('Price of European Call = ')
disp(c)
```
