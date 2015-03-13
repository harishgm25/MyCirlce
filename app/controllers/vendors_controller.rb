class VendorsController < ApplicationController
  # GET /vendors
  # GET /vendors.json
  def index
    @vendors = Vendor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vendors}
       #render :json => @vendor.to_json(:methods => [:banner_url])
    end
  end	

  # GET /vendors/1
  # GET /vendors/1.json
  def show
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vendor }
    end
  end

  # GET /vendors/new
  # GET /vendors/new.json
  def new
    @vendor = Vendor.new
    1.times{@vendor.categories.build }
    respond_to do |format|  
      format.html # new.html.erb
      format.json { render json: @vendor }
    end
  end

  # GET /vendors/1/edit
  def edit
    @vendor = Vendor.find(params[:id])
  end

  # POST /vendors
  # POST /vendors.json
  def create
    @vendor = Vendor.new(params[:vendor])

    respond_to do |format|
      if @vendor.save
        format.html { redirect_to @vendor, notice: 'Vendor was successfully created.' }
        format.json { render json: @vendor, status: :created, location: @vendor }
      else
        format.html { render action: "new" }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vendors/1
  # PUT /vendors/1.json
  def update
    @vendor = Vendor.find(params[:id])

    respond_to do |format|
      if @vendor.update_attributes(params[:vendor])
        format.html { redirect_to @vendor, notice: 'Vendor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end

  def searchbylocation
    
     rad_per_deg = Math::PI/180  # PI / 180
     rkm = 6371                  # Earth radius in kilometers
     rm = rkm * 1000             # Radius in meters
     loc1 = Array.new
     loc2 = Array.new
    
       @lat = params[:lat]
       @lon = params[:lon]
       @mdist = params[:mdist]
       
      puts "dist"+ @mdist.to_s
      puts "LAT"+ @lat.to_s
      puts "Lon"+ @lon.to_s
      
      @vendorindist = Array.new
      @vendors = Vendor.all
      @vendors.each do |vendor|
        
          loc1[0]= @lat.gsub(/[^\d\.]/, '').to_f
          loc1[1]= @lon.gsub(/[^\d\.]/, '').to_f
          loc2[0]= vendor.lati.gsub(/[^\d\.]/, '').to_f
          loc2[1]= vendor.long.gsub(/[^\d\.]/, '').to_f
          dlat_rad = (loc1[0]-loc2[0]) * rad_per_deg  # Delta, converted to rad
          dlon_rad = (loc1[1]-loc2[1]) * rad_per_deg

          lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
          lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

          a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
          c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
          dis =  rkm * c # Delta in meters
          puts "++++++++++++++++++++++++" + dis.to_s
          if( dis <= @mdist.gsub(/[^\d\.]/, '').to_f)
            puts "*******************" + dis.to_s
           
            @vendorindist<<vendor
          end
        
      end
        
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @vendorindist}
      end
      
  end
  
  def vendorscategory
    vendorid = params[:vendorid]
    @categories = Category.where(:vendor_id => vendorid)
    
       
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @categories}
      end
  end
  # DELETE /vendors/1
  # DELETE /vendors/1.json
  def destroy
    @vendor = Vendor.find(params[:id])
    @vendor.destroy

    respond_to do |format|
      format.html { redirect_to vendors_url }
      format.json { head :no_content }
    end
  end
  
  
end
