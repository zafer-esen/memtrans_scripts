function [h] = plot_reuse( ratios, NumTopDisplayed, visible )

[most_used, ind_mu] = sort(ratios,'descend');
[least_used, ind_lu] = sort(ratios,'ascend');
%values = [val(1:NumTopDisplayed) sum(val(NumTopDisplayed+1:end))];
%values = most_used(1:NumTopDisplayed);
%names = [cellstr(num2str(ind(1:NumTopDisplayed)'-1));'Other'];
names_mu = cellstr(num2str(ind_mu(1:NumTopDisplayed)'-1));
names_lu = cellstr(num2str(ind_lu(1:NumTopDisplayed)'-1));

h(1) = figure('visible', visible);
c_mu = categorical(names_mu);
c_mu = reordercats(c_mu,names_mu);
bar(c_mu, most_used(1:NumTopDisplayed));
title("Most reused byte values (at eviction)");

h(2) = figure('visible', visible);
c_lu = categorical(names_lu);
c_lu = reordercats(c_lu,names_lu);
bar(c_lu, least_used(1:NumTopDisplayed));
title("Least reused byte values (at eviction)");

end

