function [P, zd] = naiveOWD(X)
n = size(X, 1);
P = [];
zd = X;
for i = 1:n
    Y = X(i, :);
    fl = 0;
for j = 1:n
    if i ~= j
      if all(X(j, :) <= Y) && any(X(j, :) < Y)
          fl = 1;
          break
      elseif all(X(j, :) >= Y) && any(X(j, :) > Y)
          X(j, :) = inf;
      end
    end
end
if fl == 0
    P = [P; Y];
end
end
for i = 1:size(P, 1)
    ind = ismember(zd, P(i, :), 'rows');
    zd(ind, :) = [];
end 
end