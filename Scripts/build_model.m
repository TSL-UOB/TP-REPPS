function m = build_model(algSel,X,Y)
#   Build linear regression model of form y = f(x)
#
###########################################################
#   Inputs:
#   X   L by M matrix of activity vectors (regressors).
#       Each row of this matrix is an activity vector.
#   Y   L by 1 vector of dependent variables (regressand).
#       Each row of this is the correspong Power or Energy
#       consumption of the activity vectors.
#
#   Where:
#   L   Number of samples used for regression.
#   M   Number of activity measures in an activity vector.
#       lengthgth of activity vector.
#
###########################################################
#   Outputs:
#   m       M by 1 vector of Model coefficients. LS optimal
#           estimator of the model coefficients. Y ~ X*m,
#           and (Y-X*m)'*(Y-Xm) is minimal.
#   Err     L by 1 vector of % modelling error (X*m-Y)./Y
#   CLow    Lower endpoints of 95% confidence intervals
#   CHigh   Higher endpoints of 95% confidence interals

if ( algSel == 1 )
    m   = inv(X'*X)*X'*Y;   # calculate model coefficients


    Err = (X*m-Y)./Y;       # valculate % model error

    epsilon     = Y-X*m;
    s_square    = 1/(length(Y) - length(m))*epsilon'*epsilon;
    sig_square  = (length(Y)-length(m))/length(Y)*s_square;
    Qxx         = cov(X,X)+mean(X)'*mean(X);

    d           = diag(inv(Qxx));

    Alpha = 0.05;           # 1-Alpha = Confidence level

    CLow        = m - norminv(1-Alpha/2)*sqrt(1/length(Y).*sig_square.*d);
    CHigh       = m + norminv(1-Alpha/2)*sqrt(1/length(Y).*sig_square.*d);
endif    

if ( algSel == 2 )
  [m,sigma,res2] = ols(Y,X);
endif  

if ( algSel == 3 )
  m = lsqnonneg(X,Y);
endif

endfunction