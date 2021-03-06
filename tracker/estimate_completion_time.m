function [estimate] = estimate_completion_time(sequences, varargin)

failures = 8;

fps = 0.5;

repeats = 1;

args = varargin;
for j=1:2:length(args)
    switch varargin{j}
        case 'fps', fps = max(0, args{j+1});
        case 'failures', failures = max(0, args{j+1});
        case 'repeats', repeats = max(1, args{j+1});
        otherwise, error(['unrecognized argument ' args{j}]);
    end
end

total_frames = 0;

for i = 1:length(sequences)
    total_frames = total_frames + sequences{i}.length;
end;

average_frames = total_frames / length(sequences);

lens = linspace(0, 1, failures + 1);
reruns = sum(lens);

estimate = (average_frames * reruns * repeats) * length(sequences) / fps;

