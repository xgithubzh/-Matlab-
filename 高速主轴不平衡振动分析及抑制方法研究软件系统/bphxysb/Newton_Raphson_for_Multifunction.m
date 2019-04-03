%% 多元函数求解 改进的 Newton-Raphson 法
function [Xval,Fval,Jval,iterations,flag] = Newton_Raphson_for_Multifunction(Fun,X0,spc,ftol,count,A,maxit,varargin) 
if nargin<7||isempty(maxit),maxit = 100;end;if nargin<6||isempty(A), A = 1;end;if nargin<5||isempty(count),count = 0;end;if nargin<4||isempty(ftol),ftol(1:2) = 1e-12;end;
n = length(X0);G = 0;k = 1;flag = 0; F = cell(1);P = F;X = F;P{k} = ones(size(X0));X{1} = X0;
while(1)
    G = G + 1; [F{k},J] = feval(Fun,X{k},varargin{:}); d = abs(det(J));        
    if norm(F{k}(spc==0))<=ftol(1) && norm(F{k}(spc==1))<=ftol(2) ,iterations = k;  Xval = X{k};  Fval = F{k};Jval = J; flag = 1; return;%|norm(P{k})<=xtol
    elseif k>=maxit,   Xval = X{k},  Fval = F{k}, ftol, iterations = k, Jval = J,flag = -1, 
%         fprintf('\n\n Solutions not found within   ');fprintf('%d',ftol);fprintf('  tolerance after Max--- ');fprintf('%d',k);fprintf(' --- interations!\n \n');
        return;
    elseif d>=A,  P{k} = -J\F{k};
    else  P{k} = -J\F{k}*d/A;J;F{k};
    end
    if G<3, X{k+1} = X{k} + P{k};  k = k + 1; continue; end    
    if any(sign(P{k})==-sign(P{k-1})) && norm(F{k})<norm(F{k-1})
        for j = 1:count, Zj = X{k} - j*P{k};[Fzj,Jzj] = feval(Fun,Zj,varargin{:}); Sj = -Jzj\Fzj; i = find(sign(Sj)==sign(P{k-1}));
            if ~isempty(i) && any(sign(P{k}(i(1)))== -sign(P{k-1}(i(1)))), X{k+1} = Zj;  k = k + 1;   G = 0; break; end;    
        end
        if G == 0;continue;else
            for j = 1:count
                Zj = X{k} + j*P{k}; [Fzj,Jzj] = feval(Fun,Zj,varargin{:}); Sj = -Jzj\Fzj;  i = find(sign(Sj)==sign(P{k}));
                if ~isempty(i) && any(sign(P{k-1}(i(1)))== -sign(P{k}(i(1)))),X{k+1} = Zj; k = k + 1; G = 0; break; end
            end
            if G == 0, continue; else X{k+1}(1,1) = X{k}(1) + P{k}(n); X{k+1}(2:n,1) = X{k}(2:n) + P{k}(1:n-1); k = k + 1; continue; end
        end       
    else  X{k+1} = X{k} + P{k};   k = k + 1;  continue;
    end
end