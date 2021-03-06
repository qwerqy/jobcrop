class JobsController < ApplicationController
  def index
    @employer = current_user.employer
    @company = Company.find_by(employer_id: @employer.id)
    @jobs = @company.jobs
  end

  def new
    if current_user.employer
  		@job = Job.new
      @company = Company.find(params[:company_id])
    else
      redirect_to employer_index_path
    end
	end

	def create
    @employer = current_user.employer
		@job = @employer.company.jobs.build(job_params)

		if @job.save
      flash[:success] = "Job successfully posted!"
      redirect_to employer_dashboard_path
    else
      flash[:danger] = "Something's wrong! #{@job.erros.full_messages.to_sentence}"
      redirect_back(fallback_location: employer_dashboard_path)
    end
	end

	def show
    if current_user.jobhunter
		@job = Job.find_by_id(params[:id])
		@company = Company.find_by(id: @job.company_id)
    else
      flash[:warning] = "Only for Jobhunters."
      redirect_to root_path
    end
	end

	def edit
		@job = Job.find_by(id: params[:id])
	end

	def update
		@job = Job.find_by(id: params[:id])
		@job.update(job_params)
		@job.save

		redirect_to employer_job_path(@job.id)
	end

	def delete
		@job = Job.find_by(id: params[:id])
		company_id = @job.company_id
		@job.destroy
		redirect_to job_page_path(company_id)
	end

	private
	def job_params
		params.require(:job).permit(:title, :salary, :details, :address, :state, :zipcode, :country, :photos)
	end
end
