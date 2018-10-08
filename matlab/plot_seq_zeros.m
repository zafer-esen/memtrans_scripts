function [h] = plot_seq_zeros( vals, titlestr, xlabelstr, ylabelstr, visible )

h(1) = figure('visible', visible);

c = categorical({'2','3','4','5','6','7','8'});

bar(c, vals);

title(titlestr);
xlabel(xlabelstr)
ylabel(ylabelstr)
title(titlestr);
grid on

end

