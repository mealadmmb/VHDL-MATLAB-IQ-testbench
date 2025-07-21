
% Example complex vector (replace with your own)
complex_signal = [100 - 50i, 200 - 25i, 300 + 75i];

% Define output file path
filename = './complex_output.txt';

% Extract I and Q parts
I = real(complex_signal);
Q = imag(complex_signal);

% Interleave I and Q values: I0, Q0, I1, Q1, ...
interleaved = reshape([I; Q], [], 1);


% Write to file
fid = fopen(filename, 'w');
if fid == -1
    error('Could not open file for writing.');
end

for k = 1:length(interleaved)
    fprintf(fid, '%d\n', round(interleaved(k)));  % Use %.0f if float, %d for int
end

fclose(fid);

disp(['Wrote ', num2str(length(interleaved)), ' lines to file.']);
