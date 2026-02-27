# Seed Data Quick Reference Card

## 🎯 Quick Stats
- **12 Dog Caregivers** with breed specializations
- **24 Service Packages** across 5 categories
- **30+ Dog Breeds** mentioned
- **₹150-₹2,500** price range

---

## 🐕 Caregivers by Specialization

| Name | Specialization | Hourly Rate | Location |
|------|---------------|-------------|----------|
| Priya Sharma | Golden Retrievers, Labradors, German Shepherds | ₹500 | Koramangala, Bengaluru |
| Rahul Verma | Huskies, Border Collies, Beagles | ₹400 | Bandra West, Mumbai |
| Anjali Patel | Poodles, Shih Tzus, Cocker Spaniels (Groomer) | ₹600 | Whitefield, Bengaluru |
| Vikram Singh | Rottweilers, Great Danes, Mastiffs | ₹450 | Indiranagar, Bengaluru |
| Meera Reddy | Behavioral Specialist (All breeds) | ₹650 | Hitech City, Hyderabad |
| Arjun Kumar | Boxers, Dalmatians, Pointers | ₹350 | Powai, Mumbai |
| Sneha Desai | Pugs, Chihuahuas, Pomeranians, French Bulldogs | ₹420 | Andheri East, Mumbai |
| Karthik Nair | Belgian Malinois, Australian Shepherds | ₹550 | Jayanagar, Bengaluru |
| Divya Iyer | Canine Behaviorist (Anxiety, Aggression) | ₹700 | Jubilee Hills, Hyderabad |
| Amit Gupta | Multi-dog households, Mixed breeds | ₹380 | Malad West, Mumbai |
| Rohan Kapoor | Indian Breeds (Pariah, Rajapalayam) | ₹400 | Koramangala, Bengaluru |
| Neha Joshi | Puppy Specialist (8 weeks - 1 year) | ₹480 | Gurgaon, Delhi NCR |

---

## 📦 Service Packages Overview

### 🚶 Dog Walking (4 packages)
| Package | Duration | Price | Popular |
|---------|----------|-------|---------|
| Quick Potty Break | 15 min | ₹150 | |
| Basic Walk | 30 min | ₹250 | ⭐ |
| Standard Adventure | 1 hour | ₹400 | ⭐ |
| Premium Trail Experience | 2 hours | ₹650 | |

### 🏠 Dog Sitting (4 packages)
| Package | Duration | Price | Popular |
|---------|----------|-------|---------|
| Basic Home Care | 4 hours | ₹350 | |
| Full Day Care | 8 hours | ₹700 | ⭐ |
| Overnight Care | 24 hours | ₹1,200 | ⭐ |
| Extended Stay | Per day | ₹1,000 | |

### ✂️ Dog Grooming (4 packages)
| Package | Duration | Price | Popular |
|---------|----------|-------|---------|
| Bath & Brush | 45 min | ₹400 | |
| Full Grooming | 1.5 hours | ₹800 | ⭐ |
| Luxury Spa Package | 2.5 hours | ₹1,500 | |
| De-Shedding Treatment | 1.5 hours | ₹900 | |

### 🎓 Dog Training (5 packages)
| Package | Duration | Price | Popular |
|---------|----------|-------|---------|
| Basic Obedience | 1 hour | ₹600 | ⭐ |
| Puppy Foundation | 1 hour | ₹700 | ⭐ |
| Advanced Training | 1 hour | ₹800 | |
| Behavior Modification | 1.5 hours | ₹1,000 | |
| 5-Session Package | 5 sessions | ₹2,500 | ⭐ |

### 🏥 Vet Visit Companion (4 packages)
| Package | Duration | Price | Popular |
|---------|----------|-------|---------|
| Vet Transportation | 1 hour | ₹300 | |
| Vet Companion | 2 hours | ₹500 | ⭐ |
| Complete Care | 4 hours | ₹800 | |
| Emergency Support | As needed | ₹1,000 | |

---

## 🗺️ Geographic Coverage

### Bengaluru (5 caregivers)
- Koramangala (2)
- Whitefield (1)
- Indiranagar (1)
- Jayanagar (1)

### Mumbai (4 caregivers)
- Bandra West (1)
- Andheri East (1)
- Powai (1)
- Malad West (1)

### Hyderabad (2 caregivers)
- Hitech City (1)
- Jubilee Hills (1)

### Delhi NCR (1 caregiver)
- Gurgaon (1)

---

## 🏆 Top Rated Caregivers

| Name | Rating | Bookings | Specialization |
|------|--------|----------|----------------|
| Priya Sharma | 4.9 ⭐ | 145 | Training & Large Breeds |
| Anjali Patel | 4.9 ⭐ | 167 | Professional Grooming |
| Meera Reddy | 4.9 ⭐ | 189 | Behavioral Issues |
| Divya Iyer | 4.9 ⭐ | 203 | Canine Behaviorist |
| Neha Joshi | 4.9 ⭐ | 178 | Puppy Training |

---

## 💡 Quick Tips

### For First-Time Users
1. Start with "Basic Walk" or "Full Day Care"
2. Choose caregiver based on your dog's breed
3. Book puppy specialist if dog is under 1 year
4. Try "5-Session Package" for training

### For Specific Needs
- **High-energy dogs**: Rahul Verma, Arjun Kumar
- **Small breeds**: Sneha Desai
- **Behavioral issues**: Meera Reddy, Divya Iyer
- **Grooming**: Anjali Patel
- **Puppies**: Neha Joshi
- **Indian breeds**: Rohan Kapoor

### Best Value Packages
- 5-Session Training Package (Save ₹500)
- Extended Stay (15% off 5+ days)
- Luxury Spa (20% off first visit)
- Premium Trail (10% off first booking)

---

## 🔄 How to Seed

### From App
```
Profile → Seed Database
```

### Clear and Re-seed
```
Profile → Clear All Data → Seed Database
```

### Complete Reset
```
Profile → Clear Entire Database → Re-register → Seed
```

---

## 📊 Database Collections

### users (caregivers)
- Collection: `users`
- Filter: `userType == 'caregiver'`
- Count: 12 documents

### service_packages
- Collection: `service_packages`
- Count: 24 documents
- Categories: 5 service types

---

## 🎯 Popular Combinations

### Daily Dog Care
- Basic Walk (₹250) + Full Day Care (₹700) = ₹950/day

### Weekend Grooming
- Full Grooming (₹800) + Basic Walk (₹250) = ₹1,050

### Puppy Training Program
- 5-Session Package (₹2,500) + Puppy Foundation (₹700) = ₹3,200

### Vacation Care
- Extended Stay (₹1,000/day × 7 days) = ₹7,000
- With 15% discount = ₹5,950

---

## 📱 Testing Checklist

- [ ] All 12 caregivers visible
- [ ] All 24 packages load
- [ ] Breed specializations show
- [ ] Ratings display correctly
- [ ] Prices are accurate
- [ ] Popular tags appear
- [ ] Can filter by service
- [ ] Can search by breed
- [ ] Can book services

---

**Last Updated:** February 27, 2026  
**Version:** 2.0 (Dog-Specific)
