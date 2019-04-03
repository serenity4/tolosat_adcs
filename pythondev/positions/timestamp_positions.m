function positions_ts = timestamp_positions(file)
load(file); % gets t, x, y, z, vx, vy, vz in J2000 frame
positions = [x; y; z; vx; vy; vz];
positions_ts = timeseries(positions, t, 'name', 'positions_velocity');
save('positions_timestamped.mat', 'positions_ts', '-v7.3');