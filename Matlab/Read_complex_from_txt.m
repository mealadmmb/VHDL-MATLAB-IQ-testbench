% Path to your text file
filename = './complex_output.txt';  % Adjust path as needed

% Read all numbers from file
data = dlmread(filename);

% Sanity check: must have even number of lines (I/Q pairs)
if mod(length(data), 2) ~= 0
    error('The input file must contain an even number of lines (I/Q pairs).');
end

% Reshape into 2 rows: first row is I, second is Q
data_reshaped = reshape(data, 2, []);

% Extract I and Q
I = data_reshaped(1, :);  % Even lines = I
Q = data_reshaped(2, :);  % Odd lines = Q

% Combine into complex array
complex_signal = complex(I, Q);  % I + jQ

% Optional: display the result
disp('Complex signal:');
disp(complex_signal);

% Optional: plot
figure;
plot(real(complex_signal), imag(complex_signal), 'o-');
xlabel('In-phase (I)');
ylabel('Quadrature (Q)');
title('Constellation Diagram');
grid on;
