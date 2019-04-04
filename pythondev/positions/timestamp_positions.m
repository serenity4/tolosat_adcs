function positions_ts = timestamp_positions(file)
positions = jsondecode(fileread(file)) % gets t, vx, vy, vz, x, y, z in J2000 frame
t = [positions.t].';
eval('t(length(t))');
positions = [positions.vx.'; positions.vy.'; positions.vz.'; positions.x.'; positions.y.'; positions.z.'];
positions_ts = timeseries(positions, t, 'name', 'positions_velocity');
save(strcat('timestamped_', 'file'), 'positions_ts', '-v7.3');