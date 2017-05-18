# frozen_string_literal: true
namespace :search_job do
  desc 'A rake task for queueing a search job.'
  task :enqueue => :environment do # rubocop:disable Style/HashSyntax
    SearchJob.perform_async
  end
end
