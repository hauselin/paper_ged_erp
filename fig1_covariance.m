clc, clear;

rng(11); % set random seed for reproducibility

nchan = 5;
ntime = 8;
ntrials = 12;

simdat = randn([nchan,ntime, ntrials]) * 1.5;

simdat_cov_trials = zeros(nchan,nchan,ntrials);
for t=1:ntrials
    simdat_cov_trials(:,:,t) = cov(simdat(:,:,t)');
end
simdat_cov = mean(simdat_cov_trials,3);
rank(simdat_cov)

simdaterp = mean(simdat,3);
simdaterp_cov = cov(simdaterp');
rank(simdaterp_cov)

%% plotting

figure(1); clf
subplot(241)
trial2plot = randi(ntrials);
plot(1:ntime, simdat(:,:,trial2plot) + [nchan*5:-5:1]','linew',3)
xlabel('Time'); ylabel('Channel activity'); title(['Trial ' num2str(trial2plot)])
xlim([1 ntime]); yticks(''); ylim([1,nchan*5+4])
axis square

subplot(245)
imagesc(cov(simdat(:,:,trial2plot)'))
xlabel('Channel'); ylabel('Channel'); title(['Trial ' num2str(trial2plot) ' covariance'])
% colorbar
axis square

subplot(242)
trial2plot = randi(ntrials);
plot(1:ntime, simdat(:,:,trial2plot) + [nchan*5:-5:1]','linew',3)
xlabel('Time'); ylabel('Channel activity'); title(['Trial ' num2str(trial2plot)])
xlim([1 ntime]); yticks(''); ylim([1,nchan*5+4])
axis square

subplot(246)
imagesc(cov(simdat(:,:,trial2plot)'))
xlabel('Channel'); ylabel('Channel'); title(['Trial ' num2str(trial2plot) ' covariance'])
% colorbar
axis square

subplot(243)
plot(1:ntime, simdaterp + [nchan*5:-5:1]','linew',3)
xlabel('Time'); ylabel('Channel activity'); title('Average (ERP)')
xlim([1 ntime]); yticks(''); ylim([1,nchan*5+2])
axis square

subplot(244)
imagesc(simdaterp)
xlabel('Time'); ylabel('Channel activity'); title('Average (ERP image)')
% colorbar
axis square

subplot(247)
imagesc(simdaterp_cov)
xlabel('Channel'); ylabel('Channel'); title('Covariance of ERP')
% colorbar
axis square

subplot(248)
imagesc(simdat_cov)
xlabel('Channel'); ylabel('Channel'); title('Mean covariance')
% colorbar
axis square


% colormap magma % set colour map

saveas(gcf, './figures/Fig01_covariance.png')
