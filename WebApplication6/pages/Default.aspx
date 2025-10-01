<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication6.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <script src="https://cdn.tailwindcss.com"></script>
    
 <style>

        /* General */
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            color: #333;
            margin:0;

        }
        .container {

            margin: 0 !important;
            padding: 0 !important;
            max-width: 100% !important;
            border-radius: 0 !important;
            box-shadow: none !important;
        }

        /* Banner */
        .banner {
            background: url('/Images/hospital_banner.png') no-repeat center center/cover;
            
            border-radius: 10px;
            display: flex;
             flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0px 3px 8px rgba(0,0,0,0.2);
            position: relative;
            width: 100%;
            height: 400px;
            overflow: hidden;
        }
        .banner h1 {
            font-size: 36px;
            margin-bottom: 15px;
        }
        .banner p {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .banner .btn {
            padding: 12px 25px;
            background: #0066cc;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background 0.3s;
             margin-top: 15px; /* spacing below paragraph */
        }
        .banner .btn:hover {
            background: #004c99;
        }

        /* Quick Links Grid */
        .quick-links {
            display: flex;
            justify-content: space-between;          
            margin: 30px auto;
            padding: 20px;
            max-width: 1100px;
            gap: 20px;
        }
        .quick-links .card {
            flex: 1;
            background: white;
            border-radius: 8px;
            padding: 25px;
            text-align: center;
            box-shadow: 0px 2px 6px rgba(0,0,0,0.1);
            transition: 0.3s;
        }
        .quick-links .card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 5px 12px rgba(0,0,0,0.15);
        }
        .quick-links .card i {
            font-size: 40px;
            margin-bottom: 15px;
            color: #0066cc;
        }
        .quick-links .card h3 {
            margin-bottom: 10px;
        }

        /* News Section */
        .news {
            height:auto;
            margin: 30px auto;
            max-width: 1100px; 
        }
        .news h2 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 28px;
            color: #2c3e50;
        }
        .news-grid {
            display: flex;
            gap: 20px;
            justify-content: space-between;
        }
        .news-card {

            flex: 1;
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0px 2px 6px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: 0.3s;
        }
        .news-card img {
            width: 100%;
            height: 150px;
            border-radius: 6px;
            object-fit: cover;
        }
        .news-card .content {
            padding: 20px;
        }
        .news-card h3 {
            font-size: 18px;
            margin-bottom: 10px;
            color: #0066cc;
        }
        .news-card p {
            font-size: 14px;
            color: #666;
        }
        .news-card:hover {
            transform: translateY(-5px);
        }

       
    </style>

    <div class="container">
        <!-- Banner -->
        <div class="banner">
            <div>
                <h1>Welcome to RK Hospital</h1>
                <p>Caring for your health</p>
                <a href="#" class="btn">Book an Appointment</a>
            </div>
        </div>

        <!-- Quick Links -->
        <div class="quick-links">
            <div class="card">
                <i class="fa fa-stethoscope"></i>
                <h3>Our Departments</h3>
                <p>Explore specialized departments for your care</p>
            </div>
            <div class="card">
                <i class="fa fa-user-md"></i>
                <h3>Find a Doctor</h3>
                <p>Connect with expert doctors</p>
            </div>
            <div class="card">
                <i class="fa fa-hospital-o"></i>
                <h3>Patient Portal</h3>
                <p>Access your health records</p>
            </div>
        </div>

        <!-- News Section -->
        <div class="news">
            <h2>Latest News & Events</h2>
            <div class="news-grid">
                <div class="news-card">
                    <img src="/Images/news1.png" alt="News 1" />
                    <div class="content">
                        <h3>New Patient Care Initiatives</h3>
                        <p>We have launched new patient-centric care methods for better treatment.</p>
                    </div>
                </div>
                <div class="news-card">
                    <img src="/Images/news2.png" alt="News 2" />
                    <div class="content">
                        <h3>Special Health Camp</h3>
                        <p>Free health check-up camp this Sunday for cardiac patients.</p>
                    </div>
                </div>
                <div class="news-card">
                    <img src="/Images/news3.png" alt="News 3" />
                    <div class="content">
                        <h3>Hospital Rankings</h3>
                        <p>Ranked among the Top 10 Hospitals in Tamil Nadu for excellence in care.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
      <!-- Footer Section: Modernized and redesigned -->
    <footer class="bg-gray-800 text-gray-300 py-16 mt-auto">
        <div class="container mx-auto px-6 grid grid-cols-1 md:grid-cols-5 gap-12 text-center md:text-left">
            <div>
                <h4> </h4>
            </div>
            <!-- Logo and Description -->
            <div>
                <img src="/Images/Logo.png" alt="RK Hospital Logo" class="w-16 h-16 mb-4 mx-auto md:mx-0 rounded-full" />
                <h4 class="text-xl font-bold text-white mb-2">RK Hospital</h4>
                <p class="text-sm">Providing compassionate care and medical excellence since 1990.</p>
            </div>
            <!-- Contact Information -->
            <div>
                <h4 class="font-semibold text-white text-lg mb-4">Contact</h4>
                <address class="not-italic">
                    <p class="mb-2 flex items-center justify-center md:justify-start">
                        <i class="fas fa-map-marker-alt mr-2 text-gray-500"></i>
                        123 HealthCare Road, Dindigul, Tamil Nadu
                    </p>
                    <p class="mb-2 flex items-center justify-center md:justify-start">
                        <i class="fas fa-envelope mr-2 text-gray-500"></i>
                        <a href="mailto:contact@rkhospital.com" class="hover:text-white transition-colors">contact@rkhospital.com</a>
                    </p>
                    <p class="mb-2 flex items-center justify-center md:justify-start">
                        <i class="fas fa-phone-alt mr-2 text-gray-500"></i>
                        <a href="tel:+919876543210" class="hover:text-white transition-colors">+91 98765 43210</a>
                    </p>
                </address>
            </div>
            <!-- Useful Links -->
            <div>
                <h4 class="font-semibold text-white text-lg mb-4">Useful Links</h4>
                <ul class="space-y-2">
                    <li><a href="#" class="hover:text-white transition-colors">Pay Bills Online</a></li>
                    <li><a href="#" class="hover:text-white transition-colors">Medical Records</a></li>
                    <li><a href="#" class="hover:text-white transition-colors">Newsletter Signup</a></li>
                </ul>
            </div>
            <!-- Social and Quick Links -->
            <div>
                <h4 class="font-semibold text-white text-lg mb-4">Quick Links</h4>
                <ul class="space-y-2">
                    <li><a href="#" class="hover:text-white transition-colors">Departments</a></li>
                    <li><a href="#" class="hover:text-white transition-colors">Doctors</a></li>
                    <li><a href="#" class="hover:text-white transition-colors">Appointments</a></li>
                </ul>
                <div class="mt-6 flex justify-center md:justify-start space-x-4">
                    <a href="#" class="text-white hover:text-blue-500 transition-colors"><i class="fab fa-facebook-f text-2xl"></i></a>
                    <a href="#" class="text-white hover:text-blue-500 transition-colors"><i class="fab fa-twitter text-2xl"></i></a>
                    <a href="#" class="text-white hover:text-blue-500 transition-colors"><i class="fab fa-linkedin-in text-2xl"></i></a>
                    <a href="#" class="text-white hover:text-blue-500 transition-colors"><i class="fab fa-instagram text-2xl"></i></a>
                </div>
            </div>
        </div>
        <div class="border-t border-gray-700 mt-12 pt-8 text-center text-sm text-gray-500">
            &copy; 2025 RKHospital. All rights reserved.
        </div>
    </footer>
</asp:Content>

