# External References

This file contains supplementary educational material about PRD best practices. These are reference materials only and are NOT part of this skill's execution.

---

## 1. How to Write a Product Requirements Document? The Best PRD Template

**Source:** The Product Compass Newsletter  
**Author:** Paweł Huryn  
**Date:** March 9, 2024  
**Purpose:** Comprehensive guide on PRD structure, lifecycle, and best practices

### Key Sections from the Reference

#### Why Do We Need a PRD?

A PRD is NOT about documenting requirements. Instead, it's about:

1. **Documenting your product discovery** — For larger initiatives spanning weeks or more, PRDs serve as evolving workspaces that aggregate key information and support internal communication.

2. **Supporting internal alignment** — PRDs facilitate getting stakeholder buy-in and foster alignment within the organization.

3. **For existing products** — Despite common belief, PRDs are actually MORE common for existing products than for new ones.

#### What's Inside a PRD?

**2.1 Summary**
- What is this document about? Write 2-3 sentences for those who might not have time to read the entire content.

**2.2 Contacts**
- List the key stakeholders, Product Manager, Design Lead, and Lead Engineer.
- List any dedicated Slack/Teams channels for interested parties to join.

**2.3 Background**
- What is this initiative about?
- Why are you building it now? Has something changed?
- Is it something that just recently became possible (e.g., AI)?

**2.4 Objective**
- What's the objective? Why does it matter?
- How will it benefit the company and customers?
- How does it align with your vision and strategy?
- How will you measure success (key results)?

💡 Keep your objective SMART (specific, measurable, achievable, relevant, and time-bound) and inspiring. Favorite format: OKRs (Objectives and Key Results).

**2.5 Market Segment(s)**
- For whom are you building it, such as "Substack writers who struggle with acquisition."
- Are there any constraints (e.g., geographic, language, regulatory)?

💡 Markets are defined by people's problems/jobs, not their characteristics.

**2.6 Value Proposition(s)**
- What customer jobs/needs do you want to focus on?
- What will they gain, and which pains will they avoid by using your solution?
- Which of those problems will you solve way better than competitors?

💡 Consider linking research results: Opportunity Solution Tree, Jobs to be Done, interviews, surveys, or data insights. Include a Value Curve and market research insights.

**2.7 Solution**
- **UX / Prototypes:** Provide an overview of the user experience, including user flow diagrams (key screenshots) and links to prototypes (e.g., Figma).
- **Key Features:** List the key features, providing a brief description of each. Make clear how those features contribute to the overall objective and key results.
- **(Optional) Technology:** A high-level overview of the technology used, only if non-standard and relevant. Avoid detailed technical specifications.
- **Assumptions:** What are the value, usability, viability, and feasibility assumptions? Did you validate your business model, too, if applicable?

💡 A picture is worth thousands of words. Provide user flows, not just text.

**2.8 Release**
- How long could it take?
- What might be included in the first version, and what might be left for the future?

💡 Avoid exact, absolute dates. This is an estimate, not a contract. Focus on outcomes and objectives.

#### When to Write a PRD? A PRD Lifecycle

The PRD is a living document that evolves as you learn. It's updated continuously throughout the product discovery and development process.

---

## 2. A Proven AI PRD Template by Miqdad Jaffer (Product Lead @ OpenAI)

**Source:** The Product Compass Newsletter  
**Author:** Miqdad Jaffer (Product Lead @ OpenAI)  
**Collaborator:** Paweł Huryn  
**Date:** March 26, 2025  
**Purpose:** Comprehensive AI-specific PRD template with real-world Shopify case study

### How to Work With the AI PRD

#### AI PRD as a Powerful Alignment Tool

An AI PRD is the core of the AI product development lifecycle. It sits at the intersection of three areas:

1. **Strategic Context:** Defines why your company should build this product or feature, clearly identifying strategic alignment, market growth, and competitive advantage.

2. **Product & Technical Excellence:** Clearly outlines how your product creates value, detailing key features and capabilities, technical specifications, and AI-specific considerations.

3. **Go-to-Market:** Guides how you effectively communicate, launch, measure, and continuously improve your product.

#### AI PRD as a Living Document

The AI PRD is a living document. The concept is "continuous PRM mode" — a mindset in which Product Managers constantly operate in a state of testing assumptions and gathering insights.

Every interaction (Slack conversation, hallway discussion, formal meeting, customer feedback) becomes an opportunity to test assumptions about user value, usability, business viability, and feasibility.

### AI PRD Template: Key Sections & Guidance

#### 1. Executive Summary

**Purpose:** Briefly summarize the initiative and success criteria for those who won't read the entire document.

**Example:**
```
This product requirement document describes building an AI assistant integrated 
with the existing customer support chat.

It answers to an identified market opportunity (25% CAGR), is aligned with our 
company strategy, and leverages our unique competitive edge (proprietary data) 
with the pilot phase planned for the end of Q2 2025.

Success criteria:
- An 80% satisfaction (CSAT) rating
- 50% of user requests are solved automatically
- Generate accurate responses to the 25 most frequently asked FAQs
```

#### 2. Market Opportunity

**Key Questions:**
- Is this the right market growth stage (e.g., emerging, maturing, declining)?
- What is the market's current growth rate (e.g., CAGR), and what data supports this?
- What's the potential for this opportunity in the future? Can it create enough business value?

**Good Response Example:**
"Market X has shown a consistent growth rate of 25% CAGR due to recent regulatory changes and customer adoption increasing exponentially. Currently, it's at an early growth stage (10-15% market penetration), providing ample room for capturing substantial value. TAM projected at $5B by 2030."

**Common Traps to Avoid:**
- Misinterpreting temporary trends as long-term market shifts
- Failing to validate growth assumptions
- Ignoring external macroeconomic or regulatory factors

💡 Hard data beats gut feelings. Quantify the opportunity with market reports or customer surveys.

#### 3. Strategic Alignment

**Purpose:** Articulate how your AI product or feature aligns with your vision, strategy, and objectives.

**For an AI Product:**
- Does this align with our company's vision and long-term strategy?
- How does this support our company objectives?
- Does this play to our strengths and competencies?

**For an AI Feature:**
- Does this align with our company's vision and long-term strategy?
- Does this align with our product vision and strategy?
- How does this support our team objectives?

**Good Response Example:**
"Our AI-driven risk assessment product aligns with our company's focus on the finance sector. It directly supports our mid-term objective of increasing 20% mid-market bank adoption by automating regulatory compliance workflows."

**Common Traps to Avoid:**
- Not tying the initiative to company/product vision, strategy, and objectives
- Ignoring the company's competencies and resources

💡 Not every problem is the right one for your team or organization.

#### 4. Customer & User Needs

**Purpose:** Prioritize solving the highest-value user problems clearly and precisely.

**Key Questions:**
- What are the key market segments and user personas?
- What are their primary jobs-to-be-done and pain points?
- Are there any constraints (e.g., geographic, language, regulatory)?
- Which user problems, if solved, would generate the most frequent, severe, and widely experienced value?

**Good Response Example:**
"Users spend two hours daily manually reviewing data reports, resulting in frequent errors. 80% of users report this as their top pain (survey, n=200, extremely high importance, extremely low satisfaction)."

**Common Traps to Avoid:**
- Choosing low-frequency or low-severity user pains
- Assuming user pain without direct evidence or validation
- Over-generalizing user needs without specifics

💡 Use interviews, surveys, or analytics to understand and build empathy with users rather than assuming their jobs and pain points.

#### 5. Value Proposition & Messaging

**Purpose:** Communicate the unique value proposition clearly and compellingly.

**Key Questions:**
- Which problems for each market segment do we address?
- What are the key capabilities and features (high-level) that solve those problems?
- What are the benefits and customer outcomes?
- How is this different from what others offer?
- How can we clearly communicate our product's unique value?

**Good Response Example:**
"Our product reduces customer support workload by 40%, saving 10 hours weekly, clearly addressing frequent and painful user bottlenecks with AI assistants available 24/7."

**Common Traps to Avoid:**
- Generic messaging without specific, measurable user outcomes
- Listing features and capabilities without benefits
- Listing benefits without explaining how they will be achieved
- Failing to align messaging with specific market segments

💡 Adjust messaging and format to each segment and channel (e.g., cost savings for budget users).

#### 6. Competitive Advantage

**Purpose:** Clarify your product's defensibility and ability to sustain competitive advantage.

**Key Questions:**
- What makes us think competitors can't/won't copy our strategy?
- How defensible and durable is our advantage in the long-term?

**Good Response Example:**
"The product leverages our proprietary dataset of over 10M+ transactions and integrates seamlessly with our existing fraud detection system, giving us a 3-year competitive lead. While other solutions rely on generic machine learning models, our domain-specific AI is trained on industry-specific workflows, making it even harder to replicate."

**Common Traps to Avoid:**
- Vague or unclear differentiation statements
- Relying on easily replicable advantages like superficial UI features
- Underestimating competitor agility or resources
- Choosing differentiation based solely on technology
- Neglecting reassessment of competitive advantage

💡 Consider hard-to-replicate edges like data, partnerships, or integrations.

#### 7. Product Scope and Use Cases

**Purpose:** Define the key capabilities and features with tasks our product must perform exceptionally well.

**Key Questions:**
- What are the key capabilities and features?
- Can we link designs or prototypes for better alignment?
- What are the desired customer outcomes?
- What are the high-risk assumptions? How can we test them with minimal effort?

**Good Response Example:**
```
An AI assistant integrated with the existing customer support chat. It must 
generate accurate responses to the 25 most FAQs, achieving an 80% satisfaction 
(CSAT) rating.

Design: [Figma prototype]
```

**Common Traps to Avoid:**
- Trying to include too much information (every user story or corner case)
- Not specifying measurable customer outcomes
- Trying to address all user needs simultaneously
- Neglecting to test high-risk assumptions

💡 A picture is worth a thousand words. Show, don't just tell.

#### 8. Non-Functional Requirements

**8.1 General Requirements**

**Purpose:** Define the essential system attributes (e.g., performance, scalability, security) that ensure the product operates reliably.

**Good Response Example:**
```
The AI assistant:
- Delivers responses in <500ms for 95% of queries
- Scales to 50K users with 99.9% uptime
- Encrypts all user data per GDPR standards
```

**Common Traps to Avoid:**
- Overlooking scalability needs until late in development
- Writing vague requirements (e.g., "fast" or "reliable") without measurable targets
- Failing to balance trade-offs (e.g., performance vs. cost)

💡 Define specific metrics early. "Fast" isn't a target.

**8.2 AI-Specific Requirements (LLMs)**

**Purpose:** Ensure the AI consistently delivers accurate, reliable, ethical, and user-aligned outputs.

**Key Questions:**
- What are the key AI architectural choices?
- What accuracy, reliability, and ethical standards must our AI meet?
- How will we measure these qualities?
- How will we maintain them over time?

**Good Response Example:**
```
The AI must achieve ≥90% accuracy on a labeled test set of 10,000 queries, 
limit hallucination rates to <2% via RAG integration, and flag inappropriate 
outputs with 98% precision, validated monthly through human review.
```

**Common Traps to Avoid:**
- Using pre-trained models without validation or fine-tuning
- Neglecting ongoing monitoring for drift in accuracy or reliability
- Ignoring ethical risks (e.g., bias, inappropriate outputs) until user complaints arise

💡 Monitor drift. Regular monitoring, validation, and feedback loops are essential.

#### 9. Go-to-Market Approach

**Purpose:** Define how you rapidly demonstrate measurable value and grow user adoption.

**Good Response Example:**
```
We'll launch an MVP targeting small e-commerce businesses in North America, 
offering 20% cost savings on customer support within 30 days. Success will be 
measured by a 50% activation rate and 10 case studies in 90 days, driving 
expansion to mid-sized companies.
```

**Common Traps to Avoid:**
- Targeting an overly broad or poorly defined initial segment(s)
- Skipping measurable success metrics
- Confusing Early Customer Profiler (ECP) with Ideal Customer Profile (ICP)

💡 Start small, measure the results, and learn fast. Test responsibly.

### Case Study: Shopify Auto Write

**Context:** AI-powered feature leveraging LLMs to automate product description generation.

**Key Insights:**

1. **Market Opportunity:** In 2023, e-commerce GMV grew 17% to $55B. Shopify identified the need for merchant efficiency with faster, high-quality content generation.

2. **Strategic Alignment:** Auto Write aligned with Shopify's vision of making commerce simpler for merchants and supported company objectives around merchant efficiency, SEO optimization, and conversion improvement.

3. **Customer Needs:** High frequency pain — merchants struggle with manually writing product descriptions. High severity — slowed merchants down, hurting SEO and conversion rates. Wide magnitude — almost every merchant faced this.

4. **Value Proposition:** Targeted new and small merchants, cutting writing time, improving conversions, and boosting SEO. Built into Shopify's platform for seamless use (differentiator vs. generic tools).

5. **Competitive Advantage:** Deep integration into Shopify platform + access to proprietary merchant data made it hard for standalone AI tools to compete.

6. **Product Scope:** Key features included AI-generated descriptions, human-in-the-loop editing, multiple editing entry points. Target outcomes: 15% WoW usage adoption, 80% positive feedback, reduced time to publish.

7. **Non-Functional Requirements:**
   - Scale to 15% of merchants at peak load
   - Perform load tests to confirm latency targets
   - Provide disabled state if API outage

8. **AI-Specific Requirements:**
   - Used OpenAI GPT-3 (Davinci-003) with clear guardrails
   - Streamed output for lower latency
   - Limited time between regenerations
   - Moderated content for iOS (Apple App Store)
   - Quarterly review cycles for human-in-the-loop quality assurance

9. **Go-to-Market:** Released as pilot with minimal features within Shopify Magic. Focused on early-adopter merchants. Targeted realistic 15% adoption within 180 days via A/B testing. Demonstrated value with success stories.

**Key Lessons:**
- Identified compelling market opportunity tightly aligned with company strategy
- Focused on high-frequency, high-severity user pain points
- Tested assumptions (usability, accuracy)
- Defined precise non-functional and AI-specific requirements
- Stayed lean with pilot approach rather than over-engineering
- Designed feedback loops (quantitative and qualitative) for continuous improvement

---

## Notes

These references provide supplementary reading for:
- Understanding different PRD approaches and frameworks
- Learning industry best practices from experienced PMs
- Reviewing alternative templates and structures
- Real-world case studies and applications
- AI-specific PRD considerations

The `create-prd` skill is self-contained and does not require these references to function. They are provided for educational purposes and continuous learning.
