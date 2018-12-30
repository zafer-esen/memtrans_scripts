function [ ] = plotMemTrans( figname ,filename, fig_folder )

plotsVisible = 'off'; %make this on to display the plots, not only save them
%fig_folder = [filename '_fig']; %change this to change output folder name

try
    text = fileread(filename);
catch
    disp(['Could not open file: ' filename ' No such output file!'])
    return;
end

%% scalar stats
mask_st = 'Elapsed time';
mask_end = 'Other metrics';
ind_st = strfind(text, mask_st);
ind_end = strfind(text, mask_end);
lines = regexp(text(ind_st:ind_end-1),'\n','split');
% lines = lines(1:end);
tuples = regexp(lines,':','split');

% remove any spaces from tuples
stats = removeSpaces(tuples);

% fix percent signs in stats for display in latex
for i = 1:length(stats)
    if(stats{i}{2}(end) == '%')
        stats{i}{2} = [stats{i}{2}(1:end-1) '\%'];
    end
end

%% consecutive zeros
mask_st = 'Sequential 0 counts, bus-wise:';
mask_end = 'Number of bytes with value';
ind_st = strfind(text, mask_st);
ind_end = strfind(text, mask_end);
lines = regexp(text(ind_st:ind_end-1),'\n','split');
tuples = regexp(lines,':','split');
consec_zeros = removeSpaces(tuples);
for i=1:7
    consec_zeros_bw(i) = str2double(consec_zeros{i}{2});
    consec_zeros_tw(i) = str2double(consec_zeros{i+7}{2});
end

%% byte distribution
mask = 'Number of bytes with value:';
ind = strfind(text, mask);
lines = regexp(text(ind:end),'\n','split');
lines = lines(2:end);
tuples = regexp(lines,':','split');

% vals hold the byte distribution
vals = zeros(1,256);
reps = vals;
for i=1:256
    vals(i) = str2double(tuples{i}{2});
end

%% byte transition counts
% byte transition counts - bus-wise (starts after byte distribution)
tuples = tuples(259:end);
trans_distro_bw = zeros(256,256);
for i=1:256
    for j=1:256
        trans_distro_bw(i,j) = str2double(tuples{(i-1)*256 + j}{2});
    end
end

% byte transition counts - transfer-wise (follows bus-wise transition counts)
tuples = tuples(256*256+2:end);
trans_distro_tw = zeros(256,256);
for i=1:256
    for j=1:256
        trans_distro_tw(i,j) = str2double(tuples{(i-1)*256 + j}{2});
    end
end

% reuse counts for values brought into the cache
tuples = tuples(256*256+3:end)
reuse_counts = zeros(1,256);
for i=1:256
    reuse_counts(i) = str2double(tuples{i}{2});
end

% reuse ratios for values brought into the cache (normalized against
% evicted values)
tuples = tuples(259:end)
reuse_ratios = zeros(1,256);
for i=1:256
    reuse_ratios(i) = str2double(tuples{i}{2});
end

handles = [];
handles = [handles plot_distro( trans_distro_tw, 7, {'Distribution of transitioning','bytes - transfer-wise'}, 'Byte value', 'Number of occurences' , plotsVisible)];
handles = [handles plot_distro_differing( trans_distro_tw, 10, {'Distribution of transitioning bytes','transfer-wise (only differing bytes)'}, 'Byte value', 'Number of occurences', plotsVisible )];
handles = [handles plot_distro_same( trans_distro_tw, 4, {'Distribution of transitioning bytes','transfer-wise (only same byte transitions)'}, 'Byte value', 'Number of occurences', plotsVisible )];
handles = [handles plot_seq_zeros( consec_zeros_tw, 'Consecutive zeros - transfer-wise', '# of consecutive zeros', '# of occurences',plotsVisible)];

handles = [handles plot_distro( trans_distro_bw, 7, {'Distribution of transitioning', 'bytes - bus-wise'}, 'Byte value', 'Number of occurences' , plotsVisible)];
handles = [handles plot_distro_differing( trans_distro_bw, 10, {'Distribution of transitioning bytes','bus-wise (only differing bytes)'}, 'Byte value', 'Number of occurences', plotsVisible )];
handles = [handles plot_distro_same( trans_distro_bw, 4, {'Distribution of transitioning bytes','bus-wise (only same byte transitions)'}, 'Byte value', 'Number of occurences', plotsVisible )];
handles = [handles plot_seq_zeros( consec_zeros_bw, 'Consecutive zeros - bus-wise', '# of consecutive zeros', '# of occurences',plotsVisible)];

handles = [handles plot_graphs( vals, 7, 'Distribution of byte values read/written', 'Byte value', 'Number of occurences', plotsVisible )];

handles = [handles plot_reuse(reuse_ratios, 10, plotsVisible )]; %reuse/not reuse graphs

for i=1:length(handles)
    set(handles(i),'Position', [0,0,800,800])
end

%% read the latex report template before moving into the specified folder
% try to open the source latex file and read it
try
    fid = fopen('latex_source.tex');
    latexSource = fread(fid);
    fclose(fid);
catch
    disp('Could not open latex_source.tex, please ensure that this file exists next to the matlab executable.')
    return;
end

% extend every '\' character by another one, otherwise fprintf will give an
% error with latex commands
slashExtendedText = zeros(length(latexSource),1);
offset = 0;
for i=1:length(latexSource)
    slashExtendedText(i+offset) = latexSource(i);
    if latexSource(i) == '\'
        offset = offset + 1;
        slashExtendedText(i+offset) = '\'; 
    end
end

%% move into the fig folder to create the reports and the latex report
cur_folder = cd(fig_folder);
savefig(handles, figname);

for i=1:length(handles)
    saveas(handles(i),[figname '_fig' num2str(i) '.png']);
end

close(handles);

% fid = fopen([figname '_stats.txt'],'w');
% fprintf(fid,stats);
% fclose(fid);

%% create the latex report file

% The following parameters should be passed as strings to fprintf:
% JobName
% scalar stats (as many as there are)
% JobName (as many as there are)

%try to create the latex report file
try
    fid = fopen([figname '_report.tex'],'w');    
    fprintf(fid,char(slashExtendedText'),...
        figname,...
        stats{1}{1},stats{1}{2},...
        stats{2}{1},stats{2}{2},...
        stats{3}{1},stats{3}{2},...
        stats{4}{1},stats{4}{2},...
        stats{5}{1},stats{5}{2},...
        stats{6}{1},stats{6}{2},...
        stats{7}{1},stats{7}{2},...
        stats{8}{1},stats{8}{2},...
        stats{9}{1},stats{9}{2},...
        stats{10}{1},stats{10}{2},...
        stats{11}{1},stats{11}{2},...
        stats{12}{1},stats{12}{2},...
        stats{13}{1},stats{13}{2},...
        stats{14}{1},stats{14}{2},...
        stats{15}{1},stats{15}{2},...
        stats{16}{1},stats{16}{2},...
        stats{17}{1},stats{17}{2},...
        stats{18}{1},stats{18}{2},...
        stats{19}{1},stats{19}{2},...
        figname,figname,figname,figname,figname,figname,figname,figname,figname,figname,figname,figname);
    fclose(fid);
catch
    disp('Could not write the output latex report file. There might have been an error getting write access to the created file.');
end

%% the end
cd(cur_folder);
end

%% function for removing single element values inside a tuple cell list
function out = removeSpaces(in)
    ind = 1;
    for i = 1:length(in)
        if( (length(in{i}) == 2) && ~isempty(in{i}{2}))
            out(ind) = in(i);
            ind = ind+1;
        end
    end
end
