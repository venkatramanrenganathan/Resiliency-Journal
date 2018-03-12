function [ data_set ] = sdp_data_set( m )
% sdp_data_set prepares data set of both malicious and legitimate agents and
% returns the entire data set.
    angle_of_arrival = [normrnd(0.20,0.02) normrnd(0.13,0.02) normrnd(0.175,0.02) normrnd(0.09,0.02) normrnd(0.22,0.02) normrnd(0.29,0.02) normrnd(0.5,0.2) normrnd(1.5,0.2)]';
    reflected_arrival_angles = [normrnd(0.21,0.02) normrnd(0.14,0.02) normrnd(0.185,0.02) normrnd(0.10,0.02) normrnd(0.23,0.02) normrnd(0.30,0.02) normrnd(0.55,0.2) normrnd(1.55,0.2)]';
    first_amplitude = [normrnd(0.03,0.02) normrnd(0.15,0.02) normrnd(0.45,0.02) normrnd(0.85,0.02) normrnd(0.60,0.02) normrnd(0.78,0.02) normrnd(2.8,0.2) normrnd(3.0,0.2)]';
    second_amplitude = 0.5*first_amplitude;
    arrival_time = [normrnd(0.05,0.02) normrnd(0.25,0.02) normrnd(0.55,0.02) normrnd(0.95,0.02) normrnd(0.70,0.02) normrnd(0.88,0.02) normrnd(3.8,0.2) normrnd(3.9,0.2)]';
    agents_signal_fingerprints = [angle_of_arrival reflected_arrival_angles first_amplitude second_amplitude arrival_time];
    
    data_set.mu_leg = [mean(angle_of_arrival(1:6,:)) mean(reflected_arrival_angles(1:6,:)) mean(first_amplitude(1:6,:)) mean(second_amplitude(1:6,:)) mean(arrival_time(1:6,:))]';
    data_set.mu_mal = [mean(angle_of_arrival(7:m,:)) mean(reflected_arrival_angles(7:m,:)) mean(first_amplitude(7:m,:)) mean(second_amplitude(7:m,:)) mean(arrival_time(7:m,:))]';
    data_set.sigma_leg = cov(agents_signal_fingerprints(1:6,:));
    data_set.sigma_mal = cov(agents_signal_fingerprints(7:m,:));
end

