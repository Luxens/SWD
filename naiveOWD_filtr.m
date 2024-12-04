function [P, zd] = naiveOWD_filtr(X)
zd = X;
n = size(X, 1);
P = [];
for i = 1:n
    Y = X(i, :);
    j1=[];
for j = 1:n
    if i ~= j
      if all(X(j, :) < Y)
          if isempty(j1)
              Y = X(j, :);
              X(i, :) = inf;
              j1=j;
          else
              Y = X(j, :);
              X(j1, :) = inf;
              j1=j;
          end
      elseif all(X(j, :) >= Y)
          X(j, :) = inf;
      end
    end
end
P = [P; Y];
for i = 1:n
    if X(i, 1) ~= Y(1,1) || X(i, 2) ~= Y(1,2)
        if all(X(i, :) >= Y)
            X(i, :) = inf;
        end
    end
end
X(j1, :) = inf;
if isempty(j1)
    X(i,:) = inf;
else
    X(j1, :) = inf;
end
n = size(X, 1);
if n == 1
    P = [P; X];
    break;
end
end
for i = 1:size(P, 1)
    ind = ismember(zd, P(i, :), 'rows');
    zd(ind, :) = [];
end 
P(any(P == inf, 2), :) = [];
end